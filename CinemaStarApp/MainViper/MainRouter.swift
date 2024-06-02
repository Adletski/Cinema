// MainRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

typealias StartPoint = UIViewController

protocol MainRouterProtocol {
    var entry: StartPoint? { get }
    func pushDetail(id: Int)
    static func start() -> MainRouterProtocol
}

final class MainRouter: MainRouterProtocol {
    var entry: StartPoint?

    static func start() -> MainRouterProtocol {
        let router = MainRouter()
        let requestCreator = RequestCreator()
        let cacheService = CacheService(coreDataManager: CoreDataManager.shared)
        let netService = NetworkService(requestCreator: requestCreator)
        let interactor = MainInteractor(netService: netService, cacheService: cacheService)
        let presenter = MainPresenter(router: router, mainInteractor: interactor)
        let view = MainView(presenter: presenter)
        interactor.presenter = presenter
        let chaidView = UIHostingController(rootView: view)
        router.entry = chaidView
        return router
    }

    func pushDetail(id: Int) {
        let detailView = DetailRouter.start(id: id)
        entry?.navigationController?.pushViewController(detailView.entry ?? UIViewController(), animated: true)
    }
}
