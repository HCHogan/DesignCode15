//
//  MemoryGame.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/9.
//

import Foundation

struct MemoryGame<CardContent> 
where
    CardContent: Equatable
{
    // only set is private
    private(set) var cards: [Card]

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }

        set {
            cards.indices.forEach { i in
                cards[i].isFaceUp = i == newValue
            }
        }
    }

    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairOfCards x 2 cards
        (0..<numberOfPairOfCards).forEach { i in
            let content = cardContentFactory(i)
            cards.append(Card(content: content, id: "\(i + 1)a"))
            cards.append(Card(content: content, id: "\(i + 1)b"))
        }
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        // value type are passed by value, we want to modify the original value, instead of the copy
        print("card chosen: \(card.id)")
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }

    mutating func shuffle() {
        cards.shuffle()
        cards.indices.forEach { i in
            cards[i].isFaceUp = false
            cards[i].isMatched = false
        }
        print(cards)
    }

    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent

        var id: String
        var description: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "unmatched")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
