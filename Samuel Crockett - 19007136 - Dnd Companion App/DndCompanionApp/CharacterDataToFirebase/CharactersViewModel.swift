//
//  CharactersViewModel.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 14/05/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CharactersViewModel: ObservableObject {
    @Published var characters = [Character]()
    
    private var db = Firestore.firestore()
    
    
    func fetchData() {
        db.collection("CharacterSheets").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.characters = documents.map{(queryDocumentSnapshot) -> Character in
                return try! queryDocumentSnapshot.data(as: Character.self)                
            }
        }
    }
}
