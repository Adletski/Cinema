// MainModelDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// MainModuleDTO
struct MainModuleDTO: Codable {
    let docs: [FilmDocDTO]
}

/// FilmDocDTO
struct FilmDocDTO: Codable {
    let id: Int
    let name: String
    let poster: PosterDTO
    let rating: RatingDTO
}

/// PosterDTO
struct PosterDTO: Codable {
    let url: URL
}

/// RatingDTO
struct RatingDTO: Codable {
    let kp: Double
}
