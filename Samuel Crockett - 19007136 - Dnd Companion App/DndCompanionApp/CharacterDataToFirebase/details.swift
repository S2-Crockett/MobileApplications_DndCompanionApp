//
//  details.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 14/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Character: Identifiable, Codable {
    @DocumentID var id: String?
    var abilityProficiencies: [Bool]
    var abilityScores: [String]
    var armourClass: String
    var currentHp: String
    var deathSaves: [Bool]
    var levelNum: Int
    var maxHp: String
    var name: String
    var playerClass: String
    var proficiencies: [Bool]
    var race: String
    var tempHp: String
    var walkSpeed: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case abilityProficiencies
        case abilityScores
        case armourClass
        case currentHp
        case deathSaves
        case levelNum
        case maxHp
        case name
        case playerClass
        case proficiencies
        case race
        case tempHp
        case walkSpeed
    }
}
