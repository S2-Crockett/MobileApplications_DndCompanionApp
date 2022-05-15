//
//  Proficiency.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 14/05/2022.
//

import Foundation

struct Proficiency: Codable {
    let index, type, name: String
    let classes: [Reference]
    let reference: Reference
}


struct Reference: Codable {
    let index, name, url: String
}
