// Cinema.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Cinema
struct Cinema: Codable {
    let name: String
    let poster: String
    let rating: String
    let id: Int
    init(cinemaDTO: CinemaDTO) {
        name = cinemaDTO.name
        poster = cinemaDTO.poster.url ?? ""
        rating = String(format: "%.1f", cinemaDTO.rating.kp)
        id = cinemaDTO.id
    }

    init(dataCinema: FilmData) {
        name = dataCinema.name ?? ""
        poster = dataCinema.poster ?? ""
        rating = dataCinema.rating ?? ""
        id = Int(dataCinema.id)
    }
}

/// CinemaData
struct CinemaData {
    let name: String
    let poster: Data
    let rating: String
    let id: Int
}
