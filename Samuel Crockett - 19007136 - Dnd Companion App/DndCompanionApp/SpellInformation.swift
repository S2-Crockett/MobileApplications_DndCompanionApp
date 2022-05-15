//
//  SpellInformation.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 5/1/22.
//

import SwiftUI

struct SpellInformation: View {
    let data:Spells
    var spellClass = ""
    var body: some View {
        ZStack{
            Color("Grey").ignoresSafeArea()
            ScrollView{
        VStack{
            Rectangle()
                .frame(width: getRect().width/2.4, height: 90)
                .foregroundColor(Color("Red"))
                .cornerRadius(20)
                .overlay(
            Image(data.school)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipped())
        
        Text(data.name)
                .font(.custom("Vecna", size: 30))
            
            VStack(spacing: 5){
                Rectangle()
                    .frame(width: getRect().width/1.2, height: 60)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                HStack{
                    Text("Components")
                    Spacer()
                    Text(data.components.raw)
                })
                Rectangle()
                    .frame(width: getRect().width/1.2, height: 60)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                HStack{
                    Text("Casting Time")
                    Spacer()
                    Text(data.castingTime)
                })
                Rectangle()
                    .frame(width: getRect().width/1.2, height: 60)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                HStack{
                    Text("Level")
                    Spacer()
                    Text(data.level)
                })
                Rectangle()
                    .frame(width: getRect().width/1.2, height: 60)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                HStack{
                    Text("School")
                    Spacer()
                    Text(data.school)
                })
                Rectangle()
                    .frame(width: getRect().width/1.2, height: 60)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                Text("Description"))
                //Spacer()
                Rectangle()
                    .frame(width: getRect().width/1.2, height: 300)
                    .foregroundColor(Color("Red"))
                    .cornerRadius(20)
                    .overlay(
                Text(data.welcomeDescription))
            }
        }
            
        }
        .offset(y: 50)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
        .font(.custom("Vecna", size: 20))
        
    }
}

struct SpellInformation_Previews: PreviewProvider {
    static var previews: some View {
        SpellInformation(data: DataLoader().data[0])
    }
}
