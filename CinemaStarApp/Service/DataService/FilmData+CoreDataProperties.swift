// FilmData+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// FilmData
public extension FilmData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<FilmData> {
        NSFetchRequest<FilmData>(entityName: "FilmData")
    }

    @NSManaged var id: Int64
    @NSManaged var name: String?
    @NSManaged var poster: String?
    @NSManaged var query: String?
    @NSManaged var rating: String?
}

/// FilmData
extension FilmData: Identifiable {}
