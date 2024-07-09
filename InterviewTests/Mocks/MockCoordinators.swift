//
//  MockCoordinators.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

@testable import Interview
import UIKit

final class MockCoinsCoordinator: CoinsCoordinatorProtocol {
    var id: UUID = .init()

    var navigationController: UINavigationController
    var rootViewContrller: UIViewController?

    fileprivate(set) weak var parentCoordinator: (Coordinator & ParentCoordinator)?

    init() {
        let viewController = UIViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        rootViewContrller = viewController
        parentCoordinator = nil
    }

    func start(animated _: Bool) {}

    func openDetailsScreen(viewModel _: CoinDetailViewModelProtocol) {
        let mockDetailsController = UIViewController()
        navigationController.viewControllers = [navigationController.viewControllers[0], mockDetailsController]
    }
}
