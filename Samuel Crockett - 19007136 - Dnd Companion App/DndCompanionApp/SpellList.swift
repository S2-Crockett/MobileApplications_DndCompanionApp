//
//  SpellList.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 15/05/2022.
//

import SwiftUI


struct SpellList: View{
    @State private var username: String = ""
    var body: some View
    {
        let data = DataLoader().data

        ZStack{
            Color("Grey").edgesIgnoringSafeArea(.all)
            VStack{
            Rectangle()
                    .foregroundColor(Color("Red"))
                    .frame(width: 350, height: 40)
                    .cornerRadius(8)
                    .overlay(
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search For Spell", text: $username)
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
            )

                
                ScrollView{
                    VStack(spacing: 4){
                ForEach(0..<data.count){ i in
                    
                    if data[i].name.contains(username) || username == ""
                    {
                        Rectangle()
                                        .frame(width: 350, height: 100, alignment: .center)
                                        .foregroundColor(Color("Red"))
                                        .cornerRadius(8)
                                        .position(x: getRect().width/2, y: 50)
                                        .overlay(
                        NavigationLink(destination: SpellInformation(data: data[i]), label: {
                            Image(data[i].school)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .position(x: 60, y: 50)
                                .clipped();
                            Text(data[i].name)
                                .position(x: 0, y: 50)
                                .foregroundColor(.white)

                                
                        }))
                    }
                }
    
            }
                }
            }
            
            
    }
        .font(.custom("Vecna", size: 15))
}
}

struct SpellList_Previews: PreviewProvider {
    static var previews: some View {
        SpellList()
    }
}
