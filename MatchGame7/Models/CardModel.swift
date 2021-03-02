//
//  CardModel.swift
//  MatchGame7
//
//  Created by Łukasz Rajczewski on 02/03/2021.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        
        var numbersOfCards = [Int]()
        var generatedCards = [Card]()
        
        while numbersOfCards.count < 8 {
            
            let randomNumber = Int.random(in: 1...13)
            
            if !numbersOfCards.contains(randomNumber) {
                
                let cardOne = Card()
                let cardTwo = Card()
                
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                numbersOfCards.append(randomNumber)
                
                generatedCards += [cardOne, cardTwo]
                
            } // end if
            
        } // end while
        
        generatedCards.shuffle()
        
        return generatedCards
    }
    
    
}
