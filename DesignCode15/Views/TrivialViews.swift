//
//  TrivialViews.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/10.
//

import SwiftUI

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

struct FFIView: View {
    var body: some View {
        VStack {
            Text(testFFI()).font(.title).padding()
            Text(rustTokioTest()).padding()
        }
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

#Preview {
    AppStoreView()
}
