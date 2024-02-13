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
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.color)
                .animation(.default, value: viewModel.cards)
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
            // cardCountAdjusters
        }
        .padding()
        // .background(.yellow)
    }
    
    // var cardCountAdjusters: some View {
    //     HStack {
    //         cardAdder
    //         Spacer()
    //         cardRemover
    //     }
    // }
    
    // Can be put infront of any computed var or function
    @ViewBuilder
    private var cards: some View {
        // implicit return
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio ) { c in
            CardView(c)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(c)
                }
        }
        // .background(.red)
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

struct MemorizeViewPreviews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        MemorizeView(viewModel: game)
    }
}
