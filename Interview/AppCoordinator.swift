//
//  AppCoordinator.swift
//  Interview
//
//  Created by interviewee92 on 07/07/2024.
//

import UIKit

class AppCoordinator: Coordinator, ParentCoordinator {
    var navigationController: UINavigationController

    fileprivate(set) var childCoordinators: [ChildCoordinator] = []

    private var rootCoordinator: ChildCoordinator?

    init() {
        navigationController = UINavigationController(style: .shared)
    }

    func start(animated: Bool) {
        let rootCoordinator = CoinsCoordinator(
            navigationController: navigationController,
            parentCoordinator: self
        )

        self.rootCoordinator = rootCoordinator
        
        addChild(rootCoordinator)
        rootCoordinator.start(animated: animated)
    }

    func addChild(_ coordinator: Coordinator & ChildCoordinator) {
        if childCoordinators.contains(where: { $0.navigationController == coordinator.navigationController }) {
            print("\(#file) - \(type(of: coordinator)) already added as chiild")
            return
        }

        childCoordinators.append(coordinator)
    }
}
