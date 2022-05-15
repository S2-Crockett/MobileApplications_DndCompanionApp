//
//  DataLoader.swift
//  DndCompanionApp
//
//  Created by Samuel Crockett on 5/1/22.
//

import Foundation

public class DataLoader{
    
    @Published var data = [Spells]()
    
    init()
    {
        load()
    }
    func load()
    {
        if let fileLocation = Bundle.main.url(forResource: "spells", withExtension: "json")
        {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                
                let dataFromJson = try jsonDecoder.decode([Spells].self, from: data)
                
                self.data = dataFromJson
            }
            catch {
                print(error)
            }
        }
    }
    
}
