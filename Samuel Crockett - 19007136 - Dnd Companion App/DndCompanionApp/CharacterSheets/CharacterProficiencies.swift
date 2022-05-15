//
//  CharacterProficiencies.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 12/05/2022.
//

import SwiftUI

public class ProficienciesLoader{
    
    @Published var data = [Proficiency]()

    
    init()
    {
        load()
    }
    func load()
    {
        if let fileLocation = Bundle.main.url(forResource: "5e-SRD-Proficiencies", withExtension: "json")
        {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                
                let dataFromJson = try jsonDecoder.decode([Proficiency].self, from: data)
                
                self.data = dataFromJson
            }
            catch {
                print(error)
            }
        }
    }
    
}



struct CharacterProficiencies: View {
    
    let data = ProficienciesLoader().data
    
    @State var character:Character
    
    @StateObject var viewModel = CharacterViewModel()
    
    var body: some View {
        ZStack{
            Color("Grey").ignoresSafeArea()
        ScrollView{
            VStack(spacing: 1){
            Rectangle()
                            .frame(width: 350, height: 100, alignment: .center)
                            .foregroundColor(Color("Red"))
                            .cornerRadius(8)
                            .position(x: getRect().width/2, y: 50)
                            .overlay(
                                Text("Proficiences")
                                    .position(x: 190, y: 50)
                                    .foregroundColor(.white))
                Rectangle()
                                .frame(width: 350, height: 50, alignment: .center)
                                .foregroundColor(Color("Red"))
                                .cornerRadius(8)
                                .position(x: getRect().width/2, y: 50)
                                .overlay(
                                    HStack(spacing: 90){
                                    Text("Prof/")
                                    Text("/Name/")
                                    Text("/Bonus")
       
                                    }
                                        .offset(y: 25)
                                        .foregroundColor(.white))
            ForEach(0..<data.count){ i in
                if(data[i].type == "Skills"){
                    Rectangle()
                                    .frame(width: 350, height: 40, alignment: .leading)
                                    .foregroundColor(Color("Red"))
                                    .cornerRadius(8)
                                    .position(x: getRect().width/2, y: 50)
                                    .overlay(
                                        Text(data[i].reference.name)
                                                .offset(y: 30)
                                                .foregroundColor(.white))
                                    .overlay(
                                        Text(character.proficiencies[i] ? "" : "")
                                            .offset(x: 135, y: 30)
                                                .foregroundColor(.white))
                                    .overlay(Button(action: {character.proficiencies[i].toggle()})
                                                     {
                                        Image(systemName: character.proficiencies[i] ? "circle.fill" : "circle")
                                                             .resizable()
                                                             .frame(width: 20, height: 20, alignment: .leading)
                                                             //.offset(x:-146, y:30)
                                                             .foregroundColor(Color("Grey"))
                                                     }
                                                .offset(x: -145, y: 30)
                                    )

                            
                
                
            }
                
            }
        }
            

        }
        //.edgesIgnoringSafeArea([.top, .bottom])
        }
        .font(.custom("Vecna", size: 15))
    }
}

struct CharacterProficiencies_Previews: PreviewProvider {
    static var previews: some View {
        CharacterProficiencies(character: Character(abilityProficiencies: [false, false, false, false, false, false],
                                                    abilityScores: ["10","10","10","10","10","10"], armourClass: "", currentHp: "0",deathSaves: [false, false, false, false, false, false], levelNum: 1, maxHp: "0", name: "", playerClass: "",
                                                    proficiencies: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], race: "", tempHp: "0", walkSpeed: "0Ft"))
.previewInterfaceOrientation(.portrait)
    }
}
