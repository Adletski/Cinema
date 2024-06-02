// FilmDetailDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// FilmDetailDTO
struct FilmDetailDTO: Codable {
    let name: String
    let type: String
    let year: Int?
    let description: String
    let rating: RatingDTO
    let poster: PosterDTO
    let genres: [CountryDTO]
    let countries: [CountryDTO]
    let persons: [PersonDTO]?
    let spokenLanguages: [SpokenLanguageDTO]?
    let similarMovies: [SimilarMovieDTO]?
}
