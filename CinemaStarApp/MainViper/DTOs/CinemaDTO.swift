// CinemaDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// CinemaDTO
struct CinemaDTO: Codable {
    let name: String
    let id: Int
    let poster: PosterDTO
    let rating: RatingDTO
}
