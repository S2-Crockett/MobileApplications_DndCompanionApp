//
//  NewNote.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 10/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Note: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var NoteName: String
    var Note: String
}

var notes: [Note] =
[
    Note(NoteName: "New Note", Note:"Test")
]
