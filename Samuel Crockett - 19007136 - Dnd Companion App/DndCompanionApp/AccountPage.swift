//
//  AccountPage.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 15/05/2022.
//

import SwiftUI

struct AccountPage: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        ZStack{
            Color("Grey").ignoresSafeArea()
        
            VStack(spacing: 50){
        Image("Dnd Logo")
                .resizable()
                .frame(width: 200, height: 200, alignment:.center)
                .position(x: getRect().width/2, y:90)
            
            
            
            Button(action:{
                viewModel.signOut()
            }, label: {
                Rectangle()
                    .foregroundColor(Color("Red"))
                    .frame(width: getRect().width - 100, height: 150)
                    .cornerRadius(8)
                    .overlay(
                Text("Sign Out")
                    .frame(width: 200, height: 50)
                    .foregroundColor(Color.white)
            )})
                    .offset(y: -300)
                
        }
    }
        .font(.custom("Vecna", size: 30))

    
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
