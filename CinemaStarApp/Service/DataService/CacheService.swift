// CacheService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// CacheServiceProtocol
protocol CacheServiceProtocol {
    func saveFilms(query: String, films: [Cinema])
    func fetchFilms(query: String) -> [Cinema]
    func saveDetailOfFilms(film: FilmDetail, id: Int)
    func fetchDetailOfFilm(id: Int) -> FilmDetail?
}

final class CacheService {
    let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

extension CacheService: CacheServiceProtocol {
    func saveFilms(query: String, films: [Cinema]) {
        guard let filmsEntityDescription = NSEntityDescription.entity(
            forEntityName: "FilmData",
            in: coreDataManager.context
        ) else { return }
        for film in films {
            let filmData = FilmData(entity: filmsEntityDescription, insertInto: coreDataManager.context)
            filmData.name = film.name
            filmData.id = Int64(film.id)
            filmData.poster = film.poster
            filmData.rating = film.rating
            filmData.query = query
            coreDataManager.saveContext()
        }
    }

    func saveDetailOfFilms(film: FilmDetail, id: Int) {
        guard let filmsEntityDescription = NSEntityDescription.entity(
            forEntityName: "DetailFilmCD",
            in: coreDataManager.context
        ) else { return }
        let detailFilm = DetailFilmCD(entity: filmsEntityDescription, insertInto: coreDataManager.context)
        detailFilm.id = Int64(id)
        detailFilm.country = film.country
        detailFilm.descriptions = film.description
        detailFilm.language = film.language
        detailFilm.name = film.name
        detailFilm.poster = film.poster
        detailFilm.rating = film.rating
        detailFilm.type = film.type
        detailFilm.year = Int64(film.year)
        for person in film.actor {
            if let personCD = addActorThisFilm(actor: person) {
                detailFilm.addToActors(personCD)
            }
        }
        for movies in film.similarMovies {
            if let moviesCD = addSimilarMoviesThisFilm(movies: movies) {
                detailFilm.addToSimilarMovies(moviesCD)
            }
        }
        coreDataManager.saveContext()
    }

    func addActorThisFilm(actor: Person) -> ActorCD? {
        guard let actorEntityDescription = NSEntityDescription.entity(
            forEntityName: "ActorCD",
            in: coreDataManager.context
        ) else { return nil }
        let person = ActorCD(entity: actorEntityDescription, insertInto: coreDataManager.context)
        person.name = actor.name
        person.poster = actor.poster
        return person
    }

    func addSimilarMoviesThisFilm(movies: SimilarMovies) -> SimilarMoviesCD? {
        guard let moviesEntityDescription = NSEntityDescription.entity(
            forEntityName: "SimularMoviesCD",
            in: coreDataManager.context
        ) else { return nil }
        let moviesCD = SimilarMoviesCD(entity: moviesEntityDescription, insertInto: coreDataManager.context)
        moviesCD.name = movies.name
        moviesCD.poster = movies.poster
        return moviesCD
    }

    func fetchFilms(query: String) -> [Cinema] {
        do {
            let films = try? coreDataManager.context.fetch(FilmData.fetchRequest())
            guard let filmsQuary = films?.filter({ $0.query == query }) else { return [] }
            return filmsQuary.map { Cinema(dataCinema: $0) }
        }
    }

    func fetchDetailOfFilm(id: Int) -> FilmDetail? {
        do {
            let filmDetail = try? coreDataManager.context.fetch(DetailFilmCD.fetchRequest())
            guard let filmDetail else { return nil }
            for item in filmDetail {
                if item.id == id {
                    return FilmDetail(detailCD: item)
                }
            }
        }
        return nil
    }
}
