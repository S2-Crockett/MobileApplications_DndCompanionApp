//
//  NoteViewModel.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 10/05/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class NoteViewModel: ObservableObject {
    @Published var notes = [Note]()
    
    private var db = Firestore.firestore()

    
    func fetchData() {
        db.collection("Notes").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error Finding Notes")
                return
            }
            
            
            self.notes = documents.compactMap{(queryDocumentSnapshot) -> Note? in
                return try? queryDocumentSnapshot.data(as: Note.self)
            }
        }
        
    }
}
