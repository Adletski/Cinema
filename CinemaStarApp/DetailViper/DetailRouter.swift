// DetailRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

protocol DetailRouterProtocol {
    var entry: StartPoint? { get }
    static func start(id: Int) -> DetailRouterProtocol
    func popToRoot()
}

final class DetailRouter: DetailRouterProtocol {
    var entry: StartPoint?

    static func start(id: Int) -> DetailRouterProtocol {
        let router = DetailRouter()
        let requestCreator = RequestCreator()
        let netService = NetworkService(requestCreator: requestCreator)
        let cashService = CacheService(coreDataManager: CoreDataManager.shared)
        let interactor = DetailInteractor(netService: netService, cashService: cashService)
        let presenter = DetailPresenter(router: router, detailInteractor: interactor)
        presenter.id = id
        let view = DetailsView(presenter: presenter)
        interactor.presentor = presenter
        let chaidView = UIHostingController(rootView: view)
        router.entry = chaidView
        return router
    }

    func popToRoot() {
        entry?.navigationController?.popViewController(animated: true)
    }
}
