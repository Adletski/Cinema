// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

protocol MainPresenterProtocol {
    init(router: MainRouterProtocol, mainInteractor: MainInteractorProtokol)
    var stateView: ViewData { get set }
    var films: [Cinema] { get set }

    func fetch()
}

final class MainPresenter: MainPresenterProtocol, ObservableObject {
    var router: MainRouterProtocol?
    var interactor: MainInteractorProtokol?

    @Published var films: [Cinema] = []
    @Published var stateView: ViewData = .initial

    var anyCancelable: Set<AnyCancellable> = []

    required init(router: MainRouterProtocol, mainInteractor: MainInteractorProtokol) {
        interactor = mainInteractor
        self.router = router
        fetch()
    }

    func fetch() {
        stateView = .loading
        interactor?.fetch()
    }
}
