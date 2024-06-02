// Person.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Person
struct Person: Codable {
    var name: String
    var poster: String

    init(personDTO: PersonDTO) {
        name = personDTO.name ?? ""
        poster = personDTO.photo
    }

    init(personCD: ActorCD) {
        name = personCD.name ?? ""
        poster = personCD.poster ?? ""
    }
}
