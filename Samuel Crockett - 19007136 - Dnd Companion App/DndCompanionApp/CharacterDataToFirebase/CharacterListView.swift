//
//  CharacterListView.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 14/05/2022.
//

import SwiftUI




struct CharacterListView: View {
    
    @ObservedObject private var viewModel = CharactersViewModel()
    
    @State private var showNewCharacterScreen = false
    
    @State var showColours: Bool = false
    
    @State var animateButton: Bool = false
    
    var body: some View {

            ZStack{
                Color("Grey") .ignoresSafeArea()
            ScrollView{
            VStack(){
                Image("Dnd Logo")
                        .resizable()
                        .frame(width: 170, height: 170, alignment:.center)
                        .position(x: getRect().width/2, y:0)
                
            ForEach(viewModel.characters){character in
                NavigationLink(destination: CharacterSheet(data: character)) {
                    Rectangle()
                        .foregroundColor(Color("Red"))
                        .frame(width: getRect().width - 100, height: 150, alignment: .center)
                        .cornerRadius(8)
                        .overlay(
                            VStack(spacing: 20){
                                Text(character.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(character.levelNum)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(character.race)  /  \(character.playerClass)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            })
                    
                    
                }
            }
                
            
            
            }
            }
            .sheet(isPresented: $showNewCharacterScreen){
                CharacterEditView()
            }
            .onAppear(){
                self.viewModel.fetchData()
            }
        }
        .overlay(AddButton().zIndex(1)
                                    .position(x: getRect().width - getRect().width/5, y: getRect().height - getRect().height/4))
    }
    
    @ViewBuilder
    func AddButton()->some View {
        Button{
            
            showNewCharacterScreen.toggle()
            
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



struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}


    //.toolbar {
    //    ToolbarItem{
    //        Button(action: { showNewCharacterScreen.toggle() }, label: {
    //            Image(systemName: "plus")
    //        })
    //   }
    //}
