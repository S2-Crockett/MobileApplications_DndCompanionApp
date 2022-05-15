//
//  CharacterSheet.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 12/05/2022.
//

import SwiftUI

struct CharacterSheet: View {
    //@Binding var shouldPopToRootView : Bool
    
    @State var data:Character
    
    @StateObject var viewModel = CharacterViewModel()
    
    @State private var isExpanded = false

    @State private var isScrollExpanded = false
    
    @State private var initiative = ""
    @State private var hitDice = "0"
    
    
    
    var body: some View {
        
        let page1 = AnyView(
            NavigationView{
                CharacterProficiencies(character: data)
            })
        
        let pageArray: [AnyView] = [page1]
        let pageArrayName: [String] = ["Proficiencies"]
        let abilityScoreArray: [AbilityScoreInfo] = [
            AbilityScoreInfo(name: "Strength", textField: $data.abilityScores[0], modifier: calculateScore(modifier: $data.abilityScores[0])),
            AbilityScoreInfo(name: "Dexterity", textField: $data.abilityScores[1], modifier: calculateScore(modifier: $data.abilityScores[1])),
            AbilityScoreInfo(name: "Constitution", textField: $data.abilityScores[2], modifier: calculateScore(modifier: $data.abilityScores[2])),
            AbilityScoreInfo(name: "Inteligence", textField: $data.abilityScores[3], modifier: calculateScore(modifier: $data.abilityScores[3])),
            AbilityScoreInfo(name: "Wisdom", textField: $data.abilityScores[4], modifier: calculateScore(modifier: $data.abilityScores[4])),
            AbilityScoreInfo(name: "Charisma", textField: $data.abilityScores[5], modifier: calculateScore(modifier: $data.abilityScores[5]))
        ]
        let savingThrowArray: [SavingThrowInfo] = [
            SavingThrowInfo(proficient: $data.abilityProficiencies[0], name: "Strength", modifier: data.abilityProficiencies[0] ? calculateScore(modifier: $data.abilityScores[0]) + CalculateProfBonus(level: data.levelNum): calculateScore(modifier: $data.abilityScores[0]), proficiencyBonus: CalculateProfBonus(level: data.levelNum)),
            
            SavingThrowInfo(proficient: $data.abilityProficiencies[1], name: "Dexterity", modifier: data.abilityProficiencies[1] ? calculateScore(modifier: $data.abilityScores[1]) + CalculateProfBonus(level: data.levelNum): calculateScore(modifier: $data.abilityScores[1]), proficiencyBonus: CalculateProfBonus(level: data.levelNum)),
            
            SavingThrowInfo(proficient: $data.abilityProficiencies[2], name: "Constitution", modifier: data.abilityProficiencies[2] ? calculateScore(modifier: $data.abilityScores[2]) + CalculateProfBonus(level: data.levelNum): calculateScore(modifier: $data.abilityScores[2]), proficiencyBonus: CalculateProfBonus(level: data.levelNum)),
            
            SavingThrowInfo(proficient: $data.abilityProficiencies[3], name: "Inteligence", modifier: data.abilityProficiencies[3] ? calculateScore(modifier: $data.abilityScores[3]) + CalculateProfBonus(level: data.levelNum): calculateScore(modifier: $data.abilityScores[3]), proficiencyBonus: CalculateProfBonus(level: data.levelNum)),
            
            SavingThrowInfo(proficient: $data.abilityProficiencies[4], name: "Wisdom", modifier: data.abilityProficiencies[4] ? calculateScore(modifier: $data.abilityScores[4]) + CalculateProfBonus(level: data.levelNum): calculateScore(modifier: $data.abilityScores[4]), proficiencyBonus: CalculateProfBonus(level: data.levelNum)),
            
            SavingThrowInfo(proficient: $data.abilityProficiencies[5], name: "Charisma", modifier: data.abilityProficiencies[5] ? calculateScore(modifier: $data.abilityScores[5]) + CalculateProfBonus(level: data.levelNum): calculateScore(modifier: $data.abilityScores[5]), proficiencyBonus: CalculateProfBonus(level: data.levelNum))
        ]
            ZStack{
                Color("Grey").edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack(spacing: 40){
                    Rectangle()
                                    .frame(width: getRect().width - getRect().width/9, height: 100, alignment: .center)
                                    .foregroundColor(Color("Red"))
                                    .cornerRadius(8)
                                    .position(x: getRect().width/2, y: 120)
                                    .overlay(CharacterName(name: $data.name, race: $data.race, playerClass: $data.playerClass))
                    VStack{
                        DisclosureGroup("level : \(data.levelNum)", isExpanded:
                                $isScrollExpanded){
                ScrollView{
                VStack{
                    ForEach(1...20, id: \.self) {num in
                        Text("\(num)")
                            .frame(width: getRect().width - getRect().width/5)
                            .padding(5)
                            .onTapGesture{
                                data.levelNum = num
                                withAnimation{
                                    self.isScrollExpanded.toggle()
                                }
                            }
                    }
                }
                }.frame(height: 125)
            }
                    .font(.custom("Vecna", size: 25))
                    .frame(width: getRect().width - getRect().width/5)
                    .accentColor(.white)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color("Red"))
                    .cornerRadius(8)
                    .font(.title3)
                        
                        
                        
            DisclosureGroup("Title", isExpanded:
                                $isExpanded){
                VStack{
                    ForEach(0...pageArray.count - 1, id: \.self) {num in
                        NavigationLink(destination: pageArray[num]
                                        .buttonStyle(BorderlessButtonStyle()),
                    label: {
                            Text(pageArrayName[num])
                                .font(.custom("Vecna", size: 25))
                                .padding(5)
                            })
                    }
                    
                }
                //.frame(width: 100)
            }
                                .font(.custom("Vecna", size: 25))
                                .frame(width: getRect().width - getRect().width/5)
                                .accentColor(.white)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color("Red"))
                                .cornerRadius(8)
                        
 
                        Rectangle()
                                        .frame(width: getRect().width - getRect().width/9, height: 330, alignment: .center)
                                        .foregroundColor(Color("Red"))
                                        .cornerRadius(8)
                                        .overlay(CharacterInfo(level: data.levelNum, maxHp: $data.maxHp, tempHp: $data.tempHp,
                                                               currentHp: $data.currentHp,walkSpeed: $data.walkSpeed, initiative: initiative,
                                                               ac: $data.armourClass, hitDice: $hitDice, dexterity: $data.abilityScores[1]))
                                        .overlay(
                                            HStack(spacing: 20){
                                            VStack{
                                                CharacterDeathSavingThrow(data: $data.deathSaves[0])
                                                CharacterDeathSavingThrow(data: $data.deathSaves[1])
                                                CharacterDeathSavingThrow(data: $data.deathSaves[2])
                                            }.offset(y: 50)
                                                VStack{
                                                    CharacterDeathSavingThrow(data: $data.deathSaves[3])
                                                    CharacterDeathSavingThrow(data: $data.deathSaves[4])
                                                    CharacterDeathSavingThrow(data: $data.deathSaves[5])
                                                }.offset(y: 50)
                                            }
                                                .offset(x: 122, y: 70))
                        HStack(spacing: -10){
                        Rectangle()
                            .frame(width: getRect().width - getRect().width/1.75, height: 330, alignment: .center)
                                        .foregroundColor(Color("Red"))
                                        .cornerRadius(8)
                                        .padding(10)
                                        .overlay(CharacterAbilityScores(abilityScores: abilityScoreArray))
                            VStack(spacing: -10){
                            Rectangle()
                                .frame(width: getRect().width - getRect().width/1.75, height: 330, alignment: .center)
                                            .foregroundColor(Color("Red"))
                                            .cornerRadius(8)
                                            .padding(10)
                                            .overlay(CharacterSavingThrows(savingThrowInfo: savingThrowArray))
                            }
                            
                        }
                        HStack{
                        Rectangle()
                            .frame(width: getRect().width/2, height: 100, alignment: .center)
                                        .foregroundColor(Color("Red"))
                                        .cornerRadius(8)
                                        .padding(10)
                                        .overlay(
                                            //Button (action: {saveCharacter(data: data)} ){
                                            Text("Home")
                                            //}
                                        )
                        Rectangle()
                            .frame(width: getRect().width/4, height: 100, alignment: .center)
                                        .foregroundColor(Color("Red"))
                                        .cornerRadius(8)
                                        .padding(10)
                                        .overlay(
                                            Button (action: {viewModel.removeCharacter(character: data)} ){
                                            Text("Delete")
                                            }
                                        )
                        }
                        
                 Spacer()

                        
                        
                    }.offset(y: 40)
                    
                }.padding(.top, 40)
                }
            }
            .font(.custom("Vecna", size: 15))
            .onDisappear(perform: {updateCharacter(data: data)})
            //.offset(y: 30)
                .edgesIgnoringSafeArea([.top])
        
    }
        
}
func updateCharacter(data: Character) {
    @ObservedObject var viewModel = CharacterViewModel()
    viewModel.updateCharacter(data)
}


func CharacterDeathSavingThrow(data: Binding<Bool>) ->some View{
    HStack(spacing: 15){
        Button(action: {data.wrappedValue.toggle()})
        {
            Image(systemName: data.wrappedValue ? "circle.fill" : "circle")
                .resizable()
                .frame(width: 10, height: 10, alignment: .leading)
                .foregroundColor(Color("Grey"))
        }
    }
}

func CharacterSavingThrow(savingThrowInfo: SavingThrowInfo) ->some View{
    HStack(spacing: 15){
        Button(action: {savingThrowInfo.proficient.wrappedValue.toggle()})
        {
            Image(systemName: savingThrowInfo.proficient.wrappedValue ? "circle.fill" : "circle")
                .resizable()
                .frame(width: 10, height: 10, alignment: .leading)
                .foregroundColor(Color("Grey"))
        }
        Text("\(savingThrowInfo.name)")
        Spacer()
        Text(" \(savingThrowInfo.modifier)")
            .offset(x: -65)
    }.offset(x: 30)
        .font(.custom("Vecna", size: 15))
}

func CharacterSavingThrows(savingThrowInfo: [SavingThrowInfo]) ->some View{
    
    VStack(spacing: 30){
        Text("Prof  /  Name  /  Bonus")
            .font(.custom("Vecna", size: 13))
    VStack(spacing: 20){
        CharacterSavingThrow(savingThrowInfo: savingThrowInfo[0])
        CharacterSavingThrow(savingThrowInfo: savingThrowInfo[1])
        CharacterSavingThrow(savingThrowInfo: savingThrowInfo[2])
        CharacterSavingThrow(savingThrowInfo: savingThrowInfo[3])
        CharacterSavingThrow(savingThrowInfo: savingThrowInfo[4])
        CharacterSavingThrow(savingThrowInfo: savingThrowInfo[5])
    }
    .font(.custom("Vecna", size: 15))
        Text("Saving Throws")
    }
}



func CalculateProfBonus(level: Int) -> Int
{
    var prof = Double(2 + ((level - 1)/4))

    prof.round(.down)
    
    return Int(prof)
}

func CalculateSavingThrow(modifier: Int, bonus: Int,proficient: Bool) -> Int
{
    let bonus_ = CalculateProfBonus(level: bonus)
    
    var result = modifier
    
    if(proficient)
    {
        result += bonus_
    }
    
    return result
}

func CharacterName(name: Binding<String>, race: Binding<String>, playerClass: Binding<String>) ->some View{
    VStack{
        TextField("Name", text: name)
            //.offset(x: 170)
            .multilineTextAlignment(.center)
            .accentColor(.white)
            .foregroundColor(.white)
            .padding(1)
        HStack(spacing: -100){
            TextField("Race", text: race)
            .multilineTextAlignment(.center)
            .offset(x: -40)
            .accentColor(.white)
            .foregroundColor(.white)
            .padding(1)
            Text("/")
                .accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
            TextField("Class", text: playerClass)
            .multilineTextAlignment(.center)
            .offset(x: 40)
            .accentColor(.white)
            .foregroundColor(.white)
            .padding(1)
        }
    }
    .font(.custom("Vecna", size: 25))
    .offset(y: 72)
}


struct AbilityScoreInfo{
    var name: String
    var textField: Binding<String>
    @State var modifier: Int
}

struct SavingThrowInfo{
    var proficient: Binding<Bool>
    var name: String
    var modifier: Int
    var proficiencyBonus: Int
}

func calculateScore(modifier: Binding<String>) -> Int
{
    let convertedMod = Int(modifier.wrappedValue) ?? 0
    
    let result = ((convertedMod - 10) / 2)
    
    var mod = Double(result)
    
    mod.round(.down)
    
    return Int(mod)
}

func CharacterAbilityScores(abilityScores: [AbilityScoreInfo]) ->some View{
    VStack(spacing: -5){
    HStack(spacing: -20){
        ForEach(0...1, id: \.self){num in
            Image("AbilityScoreIcon")
                .resizable()
                .frame(width: 100, height: 110)
                .overlay(Text(abilityScores[num].name)
                            .offset(y: -40))
                .overlay(TextField("", text: abilityScores[num].textField)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center))
                .overlay(Text("\(abilityScores[num].modifier)")
                            .offset(y: 30))
            
        }
    }
        HStack(spacing: -20){
            ForEach(2...3, id: \.self){num in
                Image("AbilityScoreIcon")
                    .resizable()
                    .frame(width: 100, height: 110)
                    .overlay(Text(abilityScores[num].name)
                                .offset(y: -40))
                    .overlay(TextField("", text: abilityScores[num].textField)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center))
                    .overlay(Text("\(calculateScore(modifier: abilityScores[num].textField))")
                                .offset(y: 30))
            }
        }
        HStack(spacing: -20){
            ForEach(4...5, id: \.self){num in
                Image("AbilityScoreIcon")
                    .resizable()
                    .frame(width: 100, height: 110)
                    .overlay(Text(abilityScores[num].name)
                                .offset(y: -40))
                    .overlay(TextField("", text: abilityScores[num].textField)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center))
                    .overlay(Text("\(calculateScore(modifier: abilityScores[num].textField))")
                                .offset(y: 30))
            }
        }
    }
    .font(.custom("Vecna", size: 15))
}



func CharacterInfo(level: Int, maxHp: Binding<String>, tempHp: Binding<String>, currentHp: Binding<String> , walkSpeed: Binding<String>, initiative: String, ac: Binding<String>, hitDice: Binding<String>, dexterity: Binding<String>) ->some View{
    
    VStack(spacing: -90){
    HStack(spacing: 12){

        Image("CheckBox")
            .resizable()
            .frame(width: 70, height: 70)
            .overlay(Text("Prof Bonus")
                        .offset(y: -50))
            .overlay(Text("\(CalculateProfBonus(level: level))"))
        
        Image("CheckBox")
            .resizable()
            .frame(width: 70, height: 70)
            .overlay(Text("Walk Speed")
                        .offset(y: -50))
            .overlay(TextField("", text: walkSpeed)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center))
        Image("CheckBox")
            .resizable()
            .frame(width: 70, height: 70)
            .overlay(Text("Initiative")
                        .offset(y: -50))
            .overlay(Text("\(calculateScore(modifier: dexterity))")
                        .multilineTextAlignment(.center))


        Image("ShieldIcon")
            .resizable()
            .frame(width: 90, height: 90)
            .overlay(Text("AC")
                        .offset(y: -50)
                        )
            .overlay(TextField("", text: ac)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center))
            
        
    }.font(.custom("Vecna", size: 13))
    .offset(y: -100)
        HStack{
        VStack(spacing: 15){
            Image("Heart Icon")
                .resizable()
                .frame(width: 75, height: 75)
                .overlay(Text("Max HP")
                            .offset(y: -40))
                .overlay(TextField("", text: maxHp)
                            //.offset(x: 23)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center))
        

            Image("PotionIcon")
                .resizable()
                .frame(width: 75, height: 75)
                .overlay(Text("Temp HP")
                            .offset(y: -40))
                .overlay(TextField("", text: tempHp)
                            .offset(x: -5,y: 9)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center))
    }
            VStack(spacing: 15){
                Image("Heart Icon")
                    .resizable()
                    .frame(width: 155, height: 155)
                    .overlay(Text("Current HP")
                                .offset(y: -82)
                                .font(.custom("Vecna", size: 20)))
                    .overlay(TextField("", text: currentHp)
                                .font(.custom("Vecna", size: 40))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center))
                
        }
            VStack(spacing: 20){
                Image("ScrollIcon")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .overlay(Text("Hit Dice")
                                .offset(y: -40)
                                .font(.custom("Vecna", size: 12)))
                    .overlay(HStack(spacing: 3){
                        TextField("", text: hitDice)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .offset(x: 8)
                        Text("/ \(level)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        //Spacer()
                    }.offset(x: -5))
                    
                HStack(spacing: 5)
                {
                Image("Heart Icon")
                    .resizable()
                    .frame(width: 30, height: 30)
                    
                Image("SkullIcon")
                    .resizable()
                    .frame(width: 30, height: 30)
        
                }
                .overlay(Text("Death Save's")
                            .offset(y: -20)
                            .font(.custom("Vecna", size: 12)))
            
            }.offset(y: -17)
        
        }
    }.font(.custom("Vecna", size: 15))
    .offset(y: 45)
}

    


struct CharacterSheet_Previews: PreviewProvider {
    static var previews: some View {
       CharacterSheet(data: Character(abilityProficiencies: [false, false, false, false, false, false],
                                      abilityScores: ["10","10","10","10","10","10"], armourClass: "", currentHp: "0",deathSaves: [false, false, false, false, false, false], levelNum: 1, maxHp: "0", name: "", playerClass: "",
                                      proficiencies: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], race: "", tempHp: "0", walkSpeed: "0Ft"))
    }
}



