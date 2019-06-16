//
//  CardModel.swift
//  Matching Game
//
//  Created by Zongzhen Yang on 1/21/19.
//  Copyright © 2019 JackYang. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card]{
        //Declare an array to store the generated cards
        var generatedCard = [Card]()
        var numberArray = [Int]()
        
        repeat{
            let randNum = Int(arc4random_uniform(13) + 1)
            let card1 = Card()
            let card2 = Card()
            
            if(numberArray.contains(randNum) == false){
                numberArray.append(randNum)
                card1.imageName = "card\(randNum)"
                card2.imageName = "card\(randNum)"
                generatedCard.append(card1)
                generatedCard.append(card2)
            }
        }while(numberArray.count < 4)
        
        print(numberArray)
        //Randomize the array
        generatedCard.shuffle()
        
        //Return the array
        return generatedCard
    }
}
