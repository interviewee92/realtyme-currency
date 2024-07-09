//
//  Coordinator.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start(animated: Bool)
}

protocol ParentCoordinator: Coordinator {
    var childCoordinators: [ChildCoordinator] { get }

    func addChild(_ coordinator: ChildCoordinator)
}

protocol ChildCoordinator: Coordinator {
    var rootViewContrller: UIViewController? { get }
    var parentCoordinator: (ParentCoordinator)? { get }
}

extension Coordinator {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        lhs.navigationController == rhs.navigationController
    }
}

protocol CoinsCoordinatorProtocol: ChildCoordinator {
    func openDetailsScreen(viewModel: CoinDetailViewModelProtocol)
}
