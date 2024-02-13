//
//  EmojiMemoryGame.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/9.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card

    private static let emojis = ["😭", "😡", "😋", "😛", "🤪", "🤓", "😰", "😱"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 8) { i in
            if emojis.indices.contains(i) {
                emojis[i]
            } else {
                ""
            }
        }
    }

    @Published private var game = createMemoryGame()

    var cards: [Card] {
        game.cards
    }
    
    var color: Color {
        .orange
    }

    // MARK: - Intent(s)

    func shuffle() {
        game.shuffle()
    }

    func choose(_ card: Card) {
        game.choose(card)
    }

}
