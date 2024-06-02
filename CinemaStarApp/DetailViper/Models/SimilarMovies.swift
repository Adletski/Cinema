// SimilarMovies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// SimilarMovies
struct SimilarMovies: Codable {
    let name: String
    let poster: String
    init(moviesDTO: SimilarMovieDTO) {
        name = moviesDTO.name
        poster = moviesDTO.poster.url ?? ""
    }

    init(moviesCD: SimilarMoviesCD) {
        name = moviesCD.name ?? ""
        poster = moviesCD.poster ?? ""
    }
}
