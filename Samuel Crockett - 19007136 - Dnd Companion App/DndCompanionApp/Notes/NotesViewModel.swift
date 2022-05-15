//
//  NotesViewModel.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 10/05/2022.
//

import Foundation
import FirebaseFirestore

class NotesViewModel: ObservableObject {
    
    @Published var note: Note = Note(NoteName: "", Note: "")
    
    private var db = Firestore.firestore()
    
    func addNote(note: Note) {
        do{
        let _ = try db.collection("Notes").addDocument(from: note)
        }
        catch{
            print(error)
        }
    }
    
    func updateNote(_ note: Note){
        if let documentId = note.id {
            do {
                try db.collection("Notes").document(documentId).setData(from: note)
            }
            catch{
                print(error)
            }
        }
    }
    
    func removeNote(note: Note) {
        if let documentId = note.id {
            db.collection("Notes").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func save() {
        addNote(note: note)
    }
    
}
