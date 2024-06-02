// SimilarMoviesCD+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// SimilarMoviesCD
public extension SimilarMoviesCD {
    @nonobjc class func fetchRequest() -> NSFetchRequest<SimilarMoviesCD> {
        NSFetchRequest<SimilarMoviesCD>(entityName: "SimilarMoviesCD")
    }

    @NSManaged var name: String?
    @NSManaged var poster: String?
}

/// SimilarMoviesCD
extension SimilarMoviesCD: Identifiable {}
