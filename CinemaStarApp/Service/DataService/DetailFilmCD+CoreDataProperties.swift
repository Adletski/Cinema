// DetailFilmCD+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// DetailFilmCD
public extension DetailFilmCD {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DetailFilmCD> {
        NSFetchRequest<DetailFilmCD>(entityName: "DetailFilmCD")
    }

    @NSManaged var country: String?
    @NSManaged var descriptions: String?
    @NSManaged var id: Int64
    @NSManaged var language: String?
    @NSManaged var name: String?
    @NSManaged var poster: String?
    @NSManaged var rating: String?
    @NSManaged var type: String?
    @NSManaged var year: Int64
    @NSManaged var actors: Set<ActorCD>?
    @NSManaged var similarMovies: Set<SimilarMoviesCD>?
}

/// DetailFilmCD
public extension DetailFilmCD {
    @objc(addActorsObject:)
    @NSManaged func addToActors(_ value: ActorCD)

    @objc(removeActorsObject:)
    @NSManaged func removeFromActors(_ value: ActorCD)

    @objc(addActors:)
    @NSManaged func addToActors(_ values: NSSet)

    @objc(removeActors:)
    @NSManaged func removeFromActors(_ values: NSSet)
}

/// DetailFilmCD
public extension DetailFilmCD {
    @objc(addSimilarMoviesObject:)
    @NSManaged func addToSimilarMovies(_ value: SimilarMoviesCD)

    @objc(removeSimilarMoviesObject:)
    @NSManaged func removeFromSimilarMovies(_ value: SimilarMoviesCD)

    @objc(addSimilarMovies:)
    @NSManaged func addToSimilarMovies(_ values: NSSet)

    @objc(removeSimilarMovies:)
    @NSManaged func removeFromSimilarMovies(_ values: NSSet)
}

/// DetailFilmCD
extension DetailFilmCD: Identifiable {}
