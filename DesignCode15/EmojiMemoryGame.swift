//
//  EmojiMemoryGame.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/9.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    private static let emojis = ["😭", "😡", "😋", "😛", "🤪", "🤓", "😰"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 4) { i in
            if emojis.indices.contains(i) {
                emojis[i]
            } else {
                ""
            }
        }
    }

    @Published private var game = createMemoryGame()

    var cards: [MemoryGame<String>.Card] {
        game.cards
    }

    // MARK: - Intent(s)

    func shuffle() {
        game.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }

}
