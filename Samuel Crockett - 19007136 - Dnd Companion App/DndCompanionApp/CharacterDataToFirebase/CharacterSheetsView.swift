//
//  CharacterSheetsView.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 14/05/2022.
//

import SwiftUI

struct CharacterSheetsView: View {
    @State var data:Character
    
    @StateObject var viewModel = CharacterViewModel()
    
    var body: some View {
        TextField("", text: $data.name)
        Button (action: {viewModel.updateCharacter(data)} ){
        Text("Home")
        }
        Button (action: {viewModel.removeCharacter(character: data)} ){
        Text("Delete")
        }
    }
}


