//
//  Game.swift
//  Cards
//
//  Created by IosDeveloper on 04.01.2022.
//

import UIKit
class Game {
    //кол-во пар уникальных карточек
    var cardsCount =  0
    //array сгенерированных card
    var cards = [Card]()
    
    //генерация массива случайных карточек
    func generateCards(){
        var cards = [Card]()
        for _ in 0...cardsCount{
            let randomElement = (type: CardType.allCases.randomElement()!,
                color:CardColor.allCases.randomElement()!)
            cards.append(randomElement)
        }
        self.cards = cards
    }
    func checkCard(_ firsCard: Card, _ secondCard: Card) -> Bool{
        if firsCard == secondCard{
            return true
        }else{
            return false
        }
    }
}
