//
//  DesignCode15App.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2023/11/22.
//

import SwiftUI

@main
struct DesignCode15App: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            // ContentView()
//            AccountView()
            MemorizeView(viewModel: game)
        }
    }
}
