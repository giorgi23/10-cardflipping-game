//
//  CardModel.swift
//  Match app
//
//  Created by Giorgi Jashiashvili on 4/6/20.
//  Copyright © 2020 Giorgi Jashiashvili. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        var generatedNumbersArray = [Int]()
        
        var generatedCardsArray = [Card]()
        
        while generatedNumbersArray.count < 8 {
            
            let randomNumber = Int.random(in: 1...13)
            
            if generatedNumbersArray.contains(randomNumber) == false {
                
                generatedNumbersArray.append(randomNumber)
                
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                generatedCardsArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                generatedCardsArray.append(cardTwo)
                
            }
            
        }
        print(generatedNumbersArray)
        return generatedCardsArray.shuffled()
        
    }
}
