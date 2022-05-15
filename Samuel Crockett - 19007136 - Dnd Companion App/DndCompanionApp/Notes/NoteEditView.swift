//
//  NoteEditView.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 10/05/2022.
//

import SwiftUI

struct NoteEditView: View {
    
    @ObservedObject var viewModel = NotesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView{
        Form{
            Section(header: Text("Title")) {
                TextField("Title", text: $viewModel.note.NoteName)
            }
        }
        .navigationBarTitle(Text("New Note").font(.custom("Vecna", size: 20)), displayMode: .inline)
        .navigationBarItems(leading: Button(action:{handleCancelTapped()}, label:{
            Text("Cancel")
        }), trailing: Button(action: {handleDoneTapped()}, label: {
            Text("Done")
        })
        )
        }
        .font(.custom("Vecna", size: 15))
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    func handleDoneTapped() {
        viewModel.save()
        dismiss()
    }
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    
}

struct NoteEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditView()
    }
}
