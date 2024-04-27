// MainResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// MainResource
struct MainResource: APIResource {
    typealias ModelType = MainModuleDTO
    var path: String
    var queryItems: [URLQueryItem]?
}
