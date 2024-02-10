//
//  MemorizeView.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/8.
//
import SwiftUI

struct MemorizeView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    // ObservedObject means if the object says something changed, redraw the view.
    // The lifetime of this object is tied to the lifetime of the view

    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
            // cardCountAdjusters
        }
        .padding()
    }

    // var cardCountAdjusters: some View {
    //     HStack {
    //         cardAdder
    //         Spacer()
    //         cardRemover
    //     }
    // }

    var cards: some View {
        // implicit return
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            // ForEach creates a bag of Legos
            // we need an id for each element to identify which one is which, need to be unique(hashable)
            // we used id: \.self here, this means the id is the element itself
            ForEach(viewModel.cards) { c in
                CardView(c)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(c)
                    }
            }
        }
        .foregroundColor(.orange)
    }

    // var cardRemover: some View {
    //     cardCountAdjuster(by: -1, symbol: "minus")
    // }
    //
    // var cardAdder: some View {
    //     cardCountAdjuster(by: 1, symbol: "plus")
    // }
    //
    // func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
    //     Button {
    //         cardCount += offset
    //     } label: {
    //         Image(systemName: symbol).font(.largeTitle)
    //     }
    //     .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    // }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    // Turn the var into a pointer, so the view itself is still immutable
    // Temporary state for small things
    // Never use it for the game logic

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            // We use opacity instead of if else in @ViewBuilder here
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01) // if this font is too big, you can scale it down.
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(!card.isMatched ? 1 : 0)
        // .onTapGesture {
        //     print("tapped!")
        //     card.isFaceUp.toggle()
        // }
    }
}

struct MemorizeViewPreviews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        MemorizeView(viewModel: game)
    }
}
