// DetailResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DetailResource
struct DetailResource: APIResource {
    typealias ModelType = DetailModelDTO
    var path: String
    var queryItems: [URLQueryItem]?
}
