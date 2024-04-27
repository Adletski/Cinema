// MainModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Film model
struct Film {
    let imageURL: URL
    let name: String
    let rating: String
    let id: Int

    init(filmDTO: FilmDocDTO) {
        imageURL = filmDTO.poster.url
        name = filmDTO.name
        rating = String(format: "%.1f", filmDTO.rating.kp)
        id = filmDTO.id
    }
}
