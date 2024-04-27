// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AppCoordinator: BaseCoordinator {
    // MARK: - Private Methods

    override func start() {
        openMainScreen()
    }

    private func openMainScreen() {
        let mainCoordinator = MainCoordinator()
        let mainViewModel = MainViewModel(coordinator: mainCoordinator)
        let mainViewController = MainViewController()
        mainViewController.mainViewModel = mainViewModel
        mainCoordinator.setRootViewController(view: mainViewController)
        setAsRoot​(​_​: mainCoordinator.rootController ?? UIViewController())
    }
}
