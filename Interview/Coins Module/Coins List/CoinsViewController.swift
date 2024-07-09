//
//  ViewController.swift
//  Interview
//
//  Created by Przemyslaw Szurmak on 29/01/2022.
//

import Combine
import UIKit

final class CoinsViewController: UIViewController, UITableViewDelegate {
    private let viewModel: CoinsViewModelProtocol
    private let kView: CoinsViewProtocol
    private var dataSource: UITableViewDiffableDataSource<CoinListSection, CoinData>!

    private var cancellables: Set<AnyCancellable> = []
    private let cellType: CoinCellProtocol.Type

    init(view: CoinsViewProtocol,
         viewModel: CoinsViewModelProtocol,
         cellType: CoinCellProtocol.Type)
    {
        kView = view
        self.viewModel = viewModel
        self.cellType = cellType

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = kView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        setupView()
        bindData()
        viewModel.start()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.viewDidAppear()
    }

    private func setupView() {
        kView.tableView.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
        kView.tableView.delegate = self

        dataSource = UITableViewDiffableDataSource<CoinListSection, CoinData>(
            tableView: kView.tableView,
            cellProvider: { [weak self] tableView, indexPath, item in
                guard let `self` = self, let cell = tableView.dequeueReusableCell(
                    withIdentifier: self.cellType.reuseIdentifier,
                    for: indexPath
                ) as? CoinCellProtocol
                else {
                    return UITableViewCell()
                }

                cell.configure(with: item)
                return cell
            }
        )
    }

    // MARK: - UITableViewDelegate

    func tableView(_: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.viewWillShowItem(at: indexPath)
    }

    func tableView(_: UITableView, didEndDisplaying _: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.viewDidHideItem(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.userDidSelectItem(at: indexPath)
    }

    // MARK: - Private

    private func bindData() {
        viewModel.cryptoDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                var snapshot = NSDiffableDataSourceSnapshot<CoinListSection, CoinData>()
                snapshot.appendSections([.main])
                snapshot.appendItems(data, toSection: .main)
                self?.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)

        viewModel.fiatDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.configureNavigationBar(data: data)
            }
            .store(in: &cancellables)

        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.kView.setError(message: errorMessage)
            }
            .store(in: &cancellables)
    }

    private func configureNavigationBar(data: [FiatData] = []) {
        title = "Currencies"

        let fiatButton = UIBarButtonItem(title: viewModel.selectedFiat)

        let actions = data.map {
            UIAction(title: $0.id,
                     subtitle: $0.name,
                     state: $0.id == viewModel.selectedFiat ? .on : .off)
            { [weak self] action in
                self?.viewModel.selectFiat(action.title)
            }
        }

        let menu = UIMenu(title: "Change currency", children: actions)
        fiatButton.menu = menu
        navigationItem.rightBarButtonItem = fiatButton
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
