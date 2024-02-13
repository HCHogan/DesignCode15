//
//  CardView.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/11.
//

import SwiftUI


struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    
    let card: MemoryGame<String>.Card
    // Turn the var into a pointer, so the view itself is still immutable
    // Temporary state for small things
    // Never use it for the game logic
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(0.4)
            .overlay(
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01) // if this font is too big, you can scale it down.
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            )
            .padding(5)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(!card.isMatched ? 1 : 0)
    }
}

#Preview {
    typealias Card = CardView.Card
    return VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "😃", id: "test1"))
            CardView(Card(content: "😃", id: "test1"))
        }
        HStack {
            CardView(Card(isFaceUp: true, isMatched: true, content: "X", id: "test1"))
            CardView(Card(isMatched: true, content: "X", id: "test1"))
        }
    }
    .padding()
    .foregroundColor(.green)
}
