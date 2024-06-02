// ActorCD+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// ActorCD
public extension ActorCD {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ActorCD> {
        NSFetchRequest<ActorCD>(entityName: "ActorCD")
    }

    @NSManaged var name: String?
    @NSManaged var poster: String?
}

/// ActorCD
extension ActorCD: Identifiable {}
