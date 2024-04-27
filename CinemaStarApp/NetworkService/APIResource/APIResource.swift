// APIResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIResource {
    var url: URL? {
        var components = URLComponents(string: "https://api.kinopoisk.dev/v1.4/movie") ?? URLComponents()
        components.path += path
        if let queryItems {
            components.queryItems = queryItems
        }
        return components.url
    }
}
