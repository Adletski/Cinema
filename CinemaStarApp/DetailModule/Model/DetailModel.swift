// DetailModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Detail
struct Detail {
    enum MovieType: String {
        case film = "Фильм"
        case serial = "Сериал"
    }

    let poster: URL
    let name: String
    let rating: String
    let description: String
    let year: Int?
    let country: String?
    let type: MovieType
    let persons: [PersonDTO]
    let spokenLanguage: String?
    let similarMovies: [SimilarMoviesDTO]?

    init(filmDetailDTO: DetailModelDTO) {
        poster = filmDetailDTO.poster.url
        name = filmDetailDTO.name
        rating = String(format: "%.1f", filmDetailDTO.rating.kp)
        description = filmDetailDTO.description
        year = filmDetailDTO.year
        country = filmDetailDTO.countries.first?.name
        persons = filmDetailDTO.persons
        spokenLanguage = filmDetailDTO.spokenLanguages?.first?.name
        similarMovies = filmDetailDTO.similarMovies
        if filmDetailDTO.type == "movie" {
            type = .film
        } else {
            type = .serial
        }
    }
}
