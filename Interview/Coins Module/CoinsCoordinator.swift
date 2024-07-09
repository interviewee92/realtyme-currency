//
//  CoinsCoordinator.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import UIKit

final class CoinsCoordinator: CoinsCoordinatorProtocol {
    var navigationController: UINavigationController
    var rootViewContrller: UIViewController?

    fileprivate(set) weak var parentCoordinator: ParentCoordinator?

    init(navigationController: UINavigationController,
         parentCoordinator: ParentCoordinator? = nil)
    {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }

    func start(animated: Bool) {
        if let rootViewContrller = rootViewContrller, navigationController.viewControllers.contains(rootViewContrller) {
            Logger.log("Coordinator has already started", type: .error)
            return
        }

        let view = CoinsView(frame: navigationController.view.bounds)
        let fiatService = FiatService()
        let coinService = CoinService()

        let imageService = ImageService()
        let imageManager = CoinImageManager(imageService: imageService)

        let viewModel = CoinsViewModel<CoinDetailViewModel>(
            fiatService: fiatService,
            coinService: coinService,
            imageManager: imageManager,
            coordinator: self
        )

        let currenciesViewController = CoinsViewController(
            view: view,
            viewModel: viewModel,
            cellType: CoinCell.self
        )

        rootViewContrller = currenciesViewController
        navigationController.pushViewController(currenciesViewController, animated: animated)
    }

    func openDetailsScreen(viewModel: CoinDetailViewModelProtocol) {
        let detailsView = CoinDetailView(frame: navigationController.view.bounds)
        let detailsViewController = CoinDetailViewController(
            view: detailsView,
            viewModel: viewModel
        )

        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
