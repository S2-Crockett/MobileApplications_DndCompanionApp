//
//  HomePage.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 12/05/2022.
//

import SwiftUI

struct HomePage: View {
    @State var isActive : Bool = false
    var body: some View {
        ZStack{
            Color("Grey").edgesIgnoringSafeArea(.all)
        VStack(){

                
                Image("Dnd Logo")
                        .resizable()
                        .frame(width: 170, height: 170, alignment:.center)
                        .position(x: getRect().width/2, y:150)
                
            
            NavigationLink(destination: CharacterListView()
                                               .buttonStyle(BorderlessButtonStyle()))
            {
                Rectangle()
                    .frame(width: getRect().width/1.5, height: 140)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                        HStack{
                    Image("CharacterIcon")
                                .resizable()
                                .frame(width: 110, height: 100, alignment: .leading)
                    VStack{
                    Text("Character Sheets")
                                .foregroundColor(.white)
                        Text("This is where you can view your character sheets and create new ones")
                                    .foregroundColor(.white)
                                    .frame(width: 110)
                                    .font(.custom("Vecna", size: 15))
                    }
                             })
            }
                .isDetailLink(false)
            NavigationLink(destination: NotesListView()
                                               .buttonStyle(BorderlessButtonStyle()))
            {
                Rectangle()
                    .frame(width: getRect().width/1.5, height: 140)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                        HStack(){
                    Image("NotesIcon")
                                .resizable()
                                .frame(width: 110, height: 100, alignment: .leading)
                                .offset(x: -10)
                    VStack{
                    Text(" Notes ")
                                .foregroundColor(.white)
                        Text("This is where you can view your different notes and create new ones")
                                    .foregroundColor(.white)
                                    .frame(width: 100)
                                    .font(.custom("Vecna", size: 15))
                    }
                             })
            }
                .isDetailLink(false)
            NavigationLink(destination: SpellList()
                                               .buttonStyle(BorderlessButtonStyle()))
            {
                Rectangle()
                    .frame(width: getRect().width/1.5, height: 140)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                        HStack{
                    Image("Spell_Icon")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .leading)
                                .offset(x: -10)
                    VStack{
                    Text("Spells")
                        
                                .foregroundColor(.white)
                        Text("This is where you can view different spells in the game and find out more about them")
                                    .foregroundColor(.white)
                                    .frame(width: 100)
                                    .font(.custom("Vecna", size: 15))
                    }
                             })
            }
                .isDetailLink(false)
                NavigationLink(destination: AccountPage()
                                                   .buttonStyle(BorderlessButtonStyle()))
                {
                    Rectangle()
                        .frame(width: getRect().width/1.5, height: 140)
                        .foregroundColor(Color("Red"))
                        .cornerRadius(20)
                        .overlay(
                            HStack{
                        Image("AccountIcon")
                                    .resizable()
                                    .frame(width: 90, height: 90, alignment: .leading)
                                    .offset(x: -10)
                        VStack{
                        Text("Account")
                                    .foregroundColor(.white)
                            Text("This is where you can check your account")
                                        .foregroundColor(.white)
                                        .frame(width: 100)
                                        .font(.custom("Vecna", size: 15))
                        }
                                 })
                }
                    .isDetailLink(false)
        
        }
        
    }
        .font(.custom("Vecna", size: 25))
        .offset(y: -25)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
