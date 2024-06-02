// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import UIKit

/// NetworkServiceProtocol
protocol NetworkServiceProtocol {
    init(requestCreator: RequestCreatorProtocol)
    func getDetailFilm(id: String) -> AnyPublisher<FilmDetailDTO, Error>?
    func getFetchFilm(query: String) -> AnyPublisher<FilmsDTO, Error>?
    func getImage(poster: String) -> AnyPublisher<Data, URLError>?
}

final class NetworkService: NetworkServiceProtocol {
    var anyCancellable: Set<AnyCancellable> = []
    var requestCreator: RequestCreatorProtocol

    init(requestCreator: RequestCreatorProtocol) {
        self.requestCreator = requestCreator
    }

    func getFetchFilm(query: String) -> AnyPublisher<FilmsDTO, Error>? {
        guard let url = requestCreator.createFilmsRequest(query: query) else { return nil }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: FilmsDTO.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getMockData() {
        
    }

    func getDetailFilm(id: String) -> AnyPublisher<FilmDetailDTO, Error>? {
        guard let url = requestCreator.createDetailRequest(id: id) else { return nil }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: FilmDetailDTO.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    func getImage(poster: String) -> AnyPublisher<Data, URLError>? {
        guard let imageUrl = URL(string: poster) else {
            return nil
        }
        return URLSession.shared.dataTaskPublisher(for: imageUrl)
            .map(\.data)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
