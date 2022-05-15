//
//  Spells.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 5/1/22.
//

import Foundation


struct Spells: Codable {
    let castingTime: String
    let classes: [String]
    let components: Components
    let welcomeDescription, duration, level, name: String
    let range: String
    let ritual: Bool
    let school: String
    let tags: [String]
    let type: String

    enum CodingKeys: String, CodingKey {
        case castingTime = "casting_time"
        case classes, components
        case welcomeDescription = "description"
        case duration, level, name, range, ritual, school, tags, type
    }
}

struct Components: Codable {
    let material: Bool
    let raw: String
    let somatic, verbal: Bool
}
