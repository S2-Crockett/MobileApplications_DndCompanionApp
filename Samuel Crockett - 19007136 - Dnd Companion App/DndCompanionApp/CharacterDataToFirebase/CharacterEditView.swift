//
//  CharacterSheetView.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 14/05/2022.
//

import SwiftUI



struct CharacterEditView: View {
    
    @StateObject var viewModel = CharacterViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView{
        Form{
            Section(header: Text("name")){
                TextField("Name", text: $viewModel.character.name)

            }
        }
        .navigationBarTitle("New Character", displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {handleCancelTapped()}, label: {
                Text("Cancel")
            }),
            trailing: Button(action: {handeDoneTapped()}, label: {
                Text("Done")
            }))
        }
    }
    
    func handleCancelTapped(){
        dismiss()
    }
    func handeDoneTapped(){
        viewModel.save()
        dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    
    
}



struct CharacterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterEditView()
    }
}
