// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MainCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func openDetailModule(id: Int?) {
        let detailViewModel = DetailViewModel(coordinator: self, filmId: id)
        let detailViewController = DetailViewController()
        detailViewController.filmDetailViewModel = detailViewModel
        rootController?.pushViewController(detailViewController, animated: true)
    }
}
