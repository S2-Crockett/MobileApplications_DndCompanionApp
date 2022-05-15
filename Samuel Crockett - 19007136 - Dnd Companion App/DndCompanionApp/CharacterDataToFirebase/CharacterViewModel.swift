//
//  CharacterViewModel.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 14/05/2022.
//

import Foundation
import FirebaseFirestore

class CharacterViewModel: ObservableObject{
    
    @Published var character: Character = Character(abilityProficiencies: [false, false, false, false, false, false],
                                                    abilityScores: ["10","10","10","10","10","10"], armourClass: "", currentHp: "0",deathSaves: [false, false, false, false, false, false], levelNum: 1, maxHp: "0", name: "", playerClass: "",
                                                    proficiencies: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], race: "", tempHp: "0", walkSpeed: "0Ft")
    
    private var db = Firestore.firestore()
    
    func addCharacter(character: Character)
    {
        do{
        let _ = try db.collection("CharacterSheets").addDocument(from: character)
        }
        catch{
            print(error)
        }
    }
    
    func updateCharacter(_ character: Character) {
        if let documentID = character.id {
            do{
                try db.collection("CharacterSheets").document(documentID).setData(from: character)
            }
            catch{
                print(error)
            }
        }
    }
    
    func removeCharacter(character: Character) {
        if let documentId = character.id {
            db.collection("CharacterSheets").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func save(){
        addCharacter(character: character)
    }
}
