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

    var body: some View {
        VStack {
            ScrollView {
                cards
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
            ForEach(viewModel.cards.indices, id: \.self) { i in
                CardView(viewModel.cards[i])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
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
        // .onTapGesture {
        //     print("tapped!")
        //     card.isFaceUp.toggle()
        // }
    }
}

struct FooView: View {
    // Computed property
    var body: some View {
        // We can delete the parentheses only if we have a trailing closure
        VStack {
            Spacer()
            Text("shit")
        }
        HStack {
            Text("b")
        }
    }
}

// Desugars into:
struct FuckView: View {
    var body: some View {
        VStack(content: {
            ViewBuilder.buildBlock(
                Text("shits").font(.largeTitle),
                Spacer()
            )
        })
        .padding()
        // View modifier: Send them a View, returns a View
    }
}

struct AppStoreView: View {
    @State private var selectedTab = 0
    @State private var showAccountView = false

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(showAccountView: $showAccountView)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            Text("Second Tab")
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Second")
                }
                .tag(1)
        }
    }
}

struct HomeView: View {
    @Binding var showAccountView: Bool

    var body: some View {
        NavigationView {
            Text("Home Content")
                .navigationBarTitle("App Store", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showAccountView.toggle()
                    }) {
                        Image(systemName: "person.crop.circle")
                    }
                    .sheet(isPresented: $showAccountView) {
                        AccountView()
                    }
                )
        }
    }
}

struct AccountView2: View {
    @State private var username = "User Name"

    var body: some View {
        VStack {
            Text(username)
            Button("Logout") {
                print("Logout tapped!")
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppStoreView()
//    }
//}


#Preview {
    MemorizeView(viewModel: EmojiMemoryGame())
}


