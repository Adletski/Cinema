// FilmDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// FilmDetail
struct FilmDetail: Codable {
    var name: String
    var poster: String
    var rating: String
    var description: String
    var year: Int
    var country: String
    var type: String
    var actor: [Person]
    var language: String
    var similarMovies: [SimilarMovies]

    init(detailDTO: FilmDetailDTO) {
        name = detailDTO.name
        poster = detailDTO.poster.url ?? ""
        rating = String(format: "%.1f", detailDTO.rating.kp)
        description = detailDTO.description
        year = detailDTO.year ?? 0
        country = detailDTO.countries.first?.name ?? ""
        if detailDTO.type == "tv-series" {
            type = "Сериал"
        } else {
            type = "Фильм"
        }
        actor = detailDTO.persons?.compactMap { Person(personDTO: $0) } ?? []
        language = detailDTO.spokenLanguages?.first?.name ?? ""
        similarMovies = detailDTO.similarMovies?.compactMap { SimilarMovies(moviesDTO: $0) } ?? []
    }

    init(detailCD: DetailFilmCD) {
        name = detailCD.name ?? ""
        poster = detailCD.poster ?? ""
        rating = detailCD.rating ?? ""
        description = detailCD.descriptions ?? ""
        year = Int(detailCD.year)
        country = detailCD.country ?? ""
        type = detailCD.type ?? ""
        language = detailCD.language ?? ""
        if let actorsCD = detailCD.actors {
            actor = actorsCD.map { Person(personCD: $0) }
        } else {
            actor = []
        }
        if let moviesCD = detailCD.similarMovies {
            similarMovies = moviesCD.map { SimilarMovies(moviesCD: $0) }
        } else {
            similarMovies = []
        }
    }
}
