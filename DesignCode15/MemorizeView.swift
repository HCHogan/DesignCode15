//
//  MemorizeView.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/8.
//

import SwiftUI

struct MemorizeView: View {
    let emojis = ["😭", "😡", "😋", "😛", "🤪", "🤓", "😰"]
    @State var cardCount = 4

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()

    }

    var cardCountAdjusters: some View {
        HStack {
            cardAdder
            Spacer()
            cardRemover
        }
    }

    var cards: some View {
        // implicit return
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            // ForEach creates a bag of Legos
            ForEach(emojis[0..<cardCount], id: \.self) { s in
                CardView(content: s)
                    .aspectRatio(3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "minus")
    }

    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "plus")
    }

    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol).font(.largeTitle)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    // Turn the var into a pointer, so the view itself is still immutable
    // Temporary state for small things
    // Never use it for the game logic

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            // We use opacity instead of if else in @ViewBuilder here
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            print("tapped!")
            isFaceUp.toggle()
        }
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

#Preview {
    MemorizeView()
}
/*
在 Swift 中，`@ViewBuilder` 属性包装器实际上是一个语法糖，它在编译时会被转换为一个返回 `some View` 的函数。
当我们使用 `@ViewBuilder` 标记一个函数或闭包参数时，编译器会将其转换为一个返回 `some View` 的函数，并将传递给该参数的多个视图组合成一个视图层次结构。
下面是一个示例，展示了 `@ViewBuilder` 去糖后的代码：
```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Text("World")
        }
    }
}
```
上面的代码经过去糖后，实际上等价于以下代码：
```swift
struct ContentView: View {
    var body: some View {
        ViewBuilder.buildBlock(
            Text("Hello"),
            Text("World")
        )
    }
}
```

*/
