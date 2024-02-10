//
//  MemoryGame.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/9.
//

import Foundation

struct MemoryGame<CardContent> {
    // only set is private
    private(set) var cards: [Card]

    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairOfCards x 2 cards
        (0..<numberOfPairOfCards).forEach { i in
            let content = cardContentFactory(i)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    func choose(_ card: Card) {

    }

    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
    }
}

