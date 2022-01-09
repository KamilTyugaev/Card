//
//  Card.swift
//  Cards
//
//  Created by IosDeveloper on 04.01.2022.
//

import UIKit
//types figure card
enum CardType:CaseIterable {
    case circle
    case squre
    case croos
    case fill
}
//colors card
enum CardColor: CaseIterable{
    case red
    case green
    case black
    case brown
    case yellow
    case purple
    case orange
}
// игральная карточка
typealias Card = (type: CardType, color: CardColor)
