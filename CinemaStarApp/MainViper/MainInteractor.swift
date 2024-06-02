// MainInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import SwiftUI

protocol MainInteractorProtokol {
    var presenter: MainPresenterProtocol? { get set }
    init(netService: NetworkServiceProtocol, cacheService: CacheServiceProtocol)
    func fetch()
}

final class MainInteractor: MainInteractorProtokol {
    var query = "история"
    var presenter: MainPresenterProtocol?
    var netService: NetworkServiceProtocol
    var cacheService: CacheServiceProtocol
    var fetchCancebal: Set<AnyCancellable> = []
    var cancelable: AnyCancellable?
    var loadImageCancelable: Set<AnyCancellable> = []

    required init(netService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.netService = netService
        self.cacheService = cacheService
    }

    func fetch() {
        let cache = cacheService.fetchFilms(query: query)

        if cache.isEmpty {
            cancelable = netService.getFetchFilm(query: query)?
                .sink(receiveCompletion: { [unowned self] complition in
                    switch complition {
                    case .finished:
                        break
                    case .failure:
                        presenter?.stateView = .failure
                    }
                }, receiveValue: { [unowned self] films in
                    let films = films.docs.map { Cinema(cinemaDTO: $0) }
                    presenter?.films = films
                    presenter?.stateView = .success
                    cacheService.saveFilms(query: query, films: films)
                })
        } else {
            DispatchQueue.main.async {
                self.presenter?.films = cache
                self.presenter?.stateView = .success
            }
        }

        func loadMockData() {
            if let data = MockDataLoader.shared.loadMockData(filename: "mockData") {
                do {
                    let decoder = JSONDecoder()
                    let filmsDTO = try decoder.decode(FilmsDTO.self, from: data)
                    let films = filmsDTO.docs.map { Cinema(cinemaDTO: $0) }
                    presenter?.films = films
                    presenter?.stateView = .success
                } catch {
                    print("Error decoding mock data: \(error)")
                }
            }
        }
    }
}
