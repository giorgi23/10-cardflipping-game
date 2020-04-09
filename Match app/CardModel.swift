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
        
        var generatedCardsArray = [Card]()
        
        for _ in 1...8 {
            
            let randomNumber = Int.random(in: 1...13)
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            generatedCardsArray.append(cardOne)
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            generatedCardsArray.append(cardTwo)
        }
        
        return generatedCardsArray
        
    }
}
