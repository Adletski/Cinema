// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewModelProtocol {
    init(coordinator: MainCoordinator)
    var updateViewState: ((ViewState<[Film]>) -> ())? { get set }
    func startFetch()
    func showDetailFilm(id: Int?)
}

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Public Properties

    public var updateViewState: ((ViewState<[Film]>) -> ())?
    private var filmsRequest: APIRequest<MainResource>?

    // MARK: - Private Properties

    private let coordinator: MainCoordinator!

    // MARK: - Initializers

    init(coordinator: MainCoordinator) {
        updateViewState?(.loading)
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func startFetch() {
        let apiResource = MainResource(
            path: "/search",
            queryItems: [URLQueryItem(name: "query", value: "История")]
        )
        filmsRequest = APIRequest(resource: apiResource)
        filmsRequest?.execute(withCompletion: { [weak self] filmListDTO in
            guard let filmListDTO else { return }
            var films: [Film] = []
            for filmDTO in filmListDTO.docs {
                films.append(Film(filmDTO: filmDTO))
            }
            self?.updateViewState?(.data(films))
        })
    }

    func showDetailFilm(id: Int?) {
        coordinator.openDetailModule(id: id)
    }
}
