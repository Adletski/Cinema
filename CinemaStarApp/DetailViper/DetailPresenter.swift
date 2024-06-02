// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailPresenterProtocol {
    init(router: DetailRouterProtocol, detailInteractor: DetailInteractorProtokol)
    var stateView: ViewData { get set }
    var id: Int? { get set }
    var film: FilmDetail? { get set }
    var isFavorite: Bool { get set }
    var isTapLookButton: Bool { get set }
    var isFullDescription: Bool { get set }
    func fetch()
    func popViewController()
}

final class DetailPresenter: DetailPresenterProtocol, ObservableObject {
    @Published var isFullDescription: Bool = false

    @Published var isTapLookButton: Bool = false

    @Published var isFavorite: Bool = false

    var router: DetailRouterProtocol?
    var interactor: DetailInteractorProtokol?
    var id: Int?

    @Published var film: FilmDetail?
    @Published var stateView: ViewData = .initial

    required init(router: DetailRouterProtocol, detailInteractor: DetailInteractorProtokol) {
        interactor = detailInteractor
        self.router = router
    }

    func fetch() {
        stateView = .loading
        interactor?.fetch(id: id ?? 0)
    }

    func popViewController() {
        router?.popToRoot()
    }
}
