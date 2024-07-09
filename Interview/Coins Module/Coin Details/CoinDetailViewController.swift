//
//  CoinDetailViewController.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import Combine
import UIKit

final class CoinDetailViewController: UIViewController {
    private let viewModel: CoinDetailViewModelProtocol
    private let kView: CoinDetailViewProtocol

    private var cancellables: Set<AnyCancellable> = []

    init(view: CoinDetailViewProtocol,
         viewModel: CoinDetailViewModelProtocol)
    {
        kView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = kView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindData()
    }

    // MARK: Private

    private func bindData() {
        viewModel.dataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.title = data.symbol
                self?.kView.image = data.image
                self?.kView.name = data.name
                self?.kView.symbol = data.symbol
                self?.kView.hightestPrice = data.highest24hPrice
                self?.kView.lowestPrice = data.lowest24hPrice
                self?.kView.lastPrice = data.price
                self?.kView.updatedTime = data.lastUpdatedTime
                Logger.log("Refreshed details data")
            }
            .store(in: &cancellables)
    }

    // MARK: - Other

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
