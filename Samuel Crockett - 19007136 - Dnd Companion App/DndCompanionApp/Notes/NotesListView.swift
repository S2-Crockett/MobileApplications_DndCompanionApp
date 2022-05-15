//
//  NotesListView.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 10/05/2022.
//

import SwiftUI

struct NotesListView: View {

    @ObservedObject private var viewModel = NoteViewModel()
    
    @State private var presentAddNewNoteScreen = false
    
    @State var showColours: Bool = false
    
    @State var animateButton: Bool = false
    
    
    var body: some View {

            ZStack{
                Color("Grey").ignoresSafeArea()
            HStack{
                MainContent()
            }
            }
            .ignoresSafeArea()
            .overlay(SideBar())
            .onAppear(){
                self.viewModel.fetchData()
            }
        
    }
    
    
    
    @ViewBuilder
    func MainContent()->some View{
        VStack(spacing: 6)
        {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    Text("Notes")
                        .font(.custom("Vecna", size: 25))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack(){
                        
                        ForEach(viewModel.notes){note in
                            CardView(note: note)
                        }
                    }
                    .padding(.top, 30)
                }
                .padding(.top, 45)
            }
        }
        .font(.custom("Vecna", size: 15))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 40)
        .padding(.horizontal, 25)
    }
    
    @ViewBuilder
    func CardView(note: Note)->some View{
        
        VStack{
            Text(note.NoteName)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                
                Spacer(minLength: 0)
                
                NavigationLink(destination: NoteDetailEditView(data: note)
                                .buttonStyle(BorderlessButtonStyle())){
                    Image(systemName: "pencil")
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }      .isDetailLink(false)
                
            }
            .padding(.top, 55)
        }
        .padding()
        .background(Color("Red"))
        .cornerRadius(18)
    }
    
    
    @ViewBuilder
    func SideBar()->some View{
        
        VStack{
            VStack(spacing: 15){
                let colors = [Color("Light_Blue"), Color("Light_Green"),
                Color("Light_Orange"), Color("Light_Purple"), Color("Red")]
                
                ForEach(colors, id: \.self){color in
                    AddNoteButton(color: color)
                        .zIndex(0)
                }
            }
            .padding(.top, 20)
            .frame(height: showColours ? nil: 0)
            .opacity(showColours ? 1 : 0)
            .zIndex(0)
            
            AddButton()
                .zIndex(1)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.vertical, 40)

    }
    
    @ViewBuilder
    func AddNoteButton(color: Color)->some View{
        Button{
            
            
            saveNote()
            
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6))
            {
                showColours.toggle()
                animateButton.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.spring()){
                    animateButton.toggle()
                }
            }
        } label: {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
        }
    }
    
    @ViewBuilder
    func AddButton()->some View {
        Button{
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6))
            {
                showColours.toggle()
                animateButton.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.spring()){
                    animateButton.toggle()
                }
            }
        } label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .scaleEffect(animateButton ? 1.1 : 1)
                .padding(12)
                .background(Color.black)
                .clipShape(Circle())
        }
        .rotationEffect(.init(degrees: showColours ? 45 : 0))
        .scaleEffect(animateButton ? 1.1 : 1)
        .padding(.top, 30)
    }
}

func saveNote() {
    @ObservedObject var viewModel = NotesViewModel()
    viewModel.save()
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
