// DetailInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

protocol DetailInteractorProtokol {
    var presentor: DetailPresenterProtocol? { get set }
    init(netService: NetworkServiceProtocol, cashService: CacheServiceProtocol)
    func fetch(id: Int)
}

final class DetailInteractor: DetailInteractorProtokol {
    var presentor: DetailPresenterProtocol?

    var netService: NetworkServiceProtocol
    var cashServise: CacheServiceProtocol
    var fetchCancellable: Set<AnyCancellable> = []
    var anycancellable: AnyCancellable?

    required init(netService: NetworkServiceProtocol, cashService: CacheServiceProtocol) {
        self.netService = netService
        cashServise = cashService
    }

    func fetch(id: Int) {
        if let detailFilm = cashServise.fetchDetailOfFilm(id: id) {
            DispatchQueue.main.async {
                self.presentor?.film = detailFilm
                self.presentor?.stateView = .success
            }
        } else {
            anycancellable = netService.getDetailFilm(id: "\(id)")?
                .sink { [unowned self] compliton in
                    switch compliton {
                    case .finished:
                        break
                    case .failure:
                        presentor?.stateView = .failure
                    }
                } receiveValue: { [unowned self] film in
                    let filmDetailFetch = FilmDetail(detailDTO: film)
                    presentor?.film = filmDetailFetch
                    presentor?.stateView = .success
                    cashServise.saveDetailOfFilms(film: filmDetailFetch, id: id)
                }
        }
    }
}
