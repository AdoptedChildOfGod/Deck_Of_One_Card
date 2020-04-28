//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Shannon Draeker on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let value: String
    let suit: String
    let image: URL
}
