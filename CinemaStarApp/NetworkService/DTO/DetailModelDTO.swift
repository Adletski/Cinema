// DetailModelDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DetailModelDTO
struct DetailModelDTO: Codable {
    let name: String
    let poster: PosterDTO
    let rating: RatingDTO
    let description: String
    let year: Int
    let countries: [CountriesDTO]
    let type: String
    let persons: [PersonDTO]
    let spokenLanguages: [SpokenLanguageDTO]?
    let similarMovies: [SimilarMoviesDTO]?
}

/// CountriesDTO
struct CountriesDTO: Codable {
    let name: String
}

/// PersonDTO
struct PersonDTO: Codable {
    let photo: URL
    let name: String?
}

/// SpokenLanguageDTO
struct SpokenLanguageDTO: Codable {
    let name: String
}

/// SimilarMoviesDTO
struct SimilarMoviesDTO: Codable {
    let poster: PosterDTO
    let name: String
}
