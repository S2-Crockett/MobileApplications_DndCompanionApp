//
//  NoteDetailEditView.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 10/05/2022.
//

import SwiftUI

struct NoteDetailEditView: View {

    @State var data:Note
    
    @StateObject var viewModel = NotesViewModel()
    
    
    
    var body: some View {
        ZStack{
            Color("Grey").ignoresSafeArea()
            VStack{
            Rectangle()
                .frame(width: getRect().width - getRect().width/8, height: 100, alignment: .center)
                            .foregroundColor(Color("Red"))
                            .cornerRadius(8)
                            .padding(10)
                            .overlay(TextField("Title", text: $data.NoteName)
                                        .frame(width: 300, height: 100, alignment: .center)
                                        .offset(x: 130))
            
                textEditorVw
                
                Rectangle()
                    .frame(width: getRect().width/2, height: 100, alignment: .center)
                                .foregroundColor(Color("Red"))
                                .cornerRadius(8)
                                .padding(10)
                                .overlay(Button(action: {viewModel.removeNote(note: data)}, label: {Text("Delete")}))
            }
            .offset(y: 90)
            .edgesIgnoringSafeArea([.top])
        
        
        .onDisappear(perform: {viewModel.updateNote(data)})


    }
        .font(.custom("Vecna", size: 15))
    }
}

private extension NoteDetailEditView {
    
    var textEditorVw: some View {
        TextEditor(text: $data.Note)
            .colorMultiply(Color("Red"))
            .cornerRadius(8)
            .frame(width: getRect().width - getRect().width/8, height: 500, alignment: .center)

            
        
        
    }
    
    
}
