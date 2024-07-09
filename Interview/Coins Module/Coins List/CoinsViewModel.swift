//
//  CoinsViewModel.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import Foundation

final class CoinsViewModel<T: CoinDetailViewModelProtocol>: CoinsViewModelProtocol {
    var errorPublisher: Published<String?>.Publisher { $errorMessage }
    var cryptoDataPublisher: Published<[CoinData]>.Publisher { $coins }
    var fiatDataPublisher: Published<[FiatData]>.Publisher { $fiats }

    @Published private var coins: [CoinData] = []
    @Published private var fiats: [FiatData] = []
    @Published private var errorMessage: String?

    private var detailsViewModel: T?

    fileprivate(set) var selectedFiat: String = "USD"

    private var coordinator: CoinsCoordinatorProtocol
    private let fiatService: FiatServiceProtocol
    private let coinService: CoinServiceProtocol
    private let imageManager: ImageManagerProtocol
    private var reloadTask: Task<Void, Never>?

    init(fiatService: FiatServiceProtocol,
         coinService: CoinServiceProtocol,
         imageManager: ImageManagerProtocol,
         coordinator: CoinsCoordinatorProtocol)
    {
        self.coordinator = coordinator
        self.fiatService = fiatService
        self.coinService = coinService
        self.imageManager = imageManager
    }

    func start() {
        Task(priority: .background) {
            await fetchFiats()
            runReloadTask()
        }
    }

    func viewDidAppear() {
        detailsViewModel = nil
    }

    func selectFiat(_ symbol: String) {
        selectedFiat = symbol

        fiats = fiats.map {
            var fiat = $0
            fiat.isSelected = fiat.id == symbol
            return fiat
        }

        Logger.log("Did change FIAT currency selection to \(symbol)")

        runReloadTask()
    }

    func viewWillShowItem(at indexPath: IndexPath) {
        guard indexPath.row < coins.count else { return }
        let coin = coins[indexPath.row]

        if coin.image == nil {
            imageManager.downloadAndCacheImage(
                item: coin,
                key: coin.symbol,
                urlString: coin.imageUrlString
            ) { refVal, image in
                DispatchQueue.main.async { [weak self] in
                    if let index = self?.coins.firstIndex(of: refVal) {
                        self?.coins[index].image = image
                    }
                }
            }
        }
    }

    func viewDidHideItem(at indexPath: IndexPath) {
        guard indexPath.row < coins.count else { return }
        let cryptoKey = coins[indexPath.row].symbol
        imageManager.cancelImageDownload(for: cryptoKey)
    }

    func userDidSelectItem(at indexPath: IndexPath) {
        guard indexPath.row < coins.count else { return }

        let coinData = coins[indexPath.row]
        let detailsViewModel = T(coinData: coinData)
        coordinator.openDetailsScreen(viewModel: detailsViewModel)
        self.detailsViewModel = detailsViewModel
    }

    // MARK: - Private

    private func runReloadTask() {
        reloadTask?.cancel()

        reloadTask = Task(priority: .background) {
            repeat {
                await fetchCoins()
                try? await Task.sleep(nanoseconds: 10_000_000_000)
            } while Task.isCancelled == false
        }
    }

    private func fetchCoins() async {
        do {
            let coinModels = try await coinService
                .fetchCoins(fiat: selectedFiat)

            coins = coinModels.map {
                CoinData(
                    name: $0.name,
                    symbol: $0.symbol.uppercased(),
                    price: "\($0.currentPrice) \(selectedFiat)",
                    lowest24hPrice: "\($0.low24H) \(selectedFiat)",
                    highest24hPrice: "\($0.high24H) \(selectedFiat)",
                    lastUpdatedTime: $0.lastUpdated.formatted(),
                    imageUrlString: $0.image,
                    image: imageManager.getImage(for: $0.symbol)
                )
            }

            if let detailsViewModel = detailsViewModel {
                if let match = coins.first(where: { $0.symbol == detailsViewModel.coinData.symbol }) {
                    self.detailsViewModel?.coinData = match
                }
            }

            errorMessage = nil

            Logger.log("Did fetch crypto currencies")
        } catch {
            errorMessage = error.localizedDescription
            Logger.log(error.localizedDescription, type: .error)

            if let error = error as? CoingeckoErrorModel.CoingeckoError, error == .invalidCurrency {
                reloadTask?.cancel()
            }
        }
    }

    private func fetchFiats() async {
        do {
            let fiatModels = try await fiatService
                .fetchFiats()
                .sorted { $0.id < $1.id }

            fiats = fiatModels.map {
                .init(id: $0.id,
                      name: $0.name,
                      isSelected: $0.id.lowercased() == selectedFiat.lowercased())
            }

            if let fiat = fiatModels.first?.id {
                selectedFiat = fiat
            }

            Logger.log("Did fetch fiat currencies")
        } catch {
            Logger.log(error.localizedDescription, type: .error)
        }
    }
}
