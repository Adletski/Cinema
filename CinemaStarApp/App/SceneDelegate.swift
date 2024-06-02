// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let router = MainRouter.start()
        guard let routers = router.entry else { return }
        let navigationController = UINavigationController(rootViewController: routers)
        navigationController.navigationBar.tintColor = .clear
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
    }
}
