// RequestCreator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// RequestCreatorProtocol
protocol RequestCreatorProtocol {
    func createFilmsRequest(query: String) -> URLRequest?
    func createDetailRequest(id: String) -> URLRequest?
}

final class RequestCreator: RequestCreatorProtocol {
    private enum Constants {
        static let host = "api.kinopoisk.dev"
        static let sheme = "https"
    }

    private func createQueryItems() -> [URLQueryItem] {
        let historyQuery = URLQueryItem(name: "query", value: "история")
        return [historyQuery]
    }

    func createFilmsRequest(query: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = Constants.sheme
        components.host = Constants.host
        components.path = "/v1.4/movie/search"
        components.queryItems = [URLQueryItem(name: "query", value: query)]
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("EMDMJR3-N0M41NQ-PJK1NKB-Q9Z0YFN", forHTTPHeaderField: "X-API-KEY")
        return request
    }

    func createDetailRequest(id: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = Constants.sheme
        components.host = Constants.host
        components.path = "/v1.4/movie/\(id)"
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("EMDMJR3-N0M41NQ-PJK1NKB-Q9Z0YFN", forHTTPHeaderField: "X-API-KEY")
        return request
    }
}
