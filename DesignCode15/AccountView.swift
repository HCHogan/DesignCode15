//
//  AccountView.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2023/11/22.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            List {
                nameCard
                // .frame(maxWidth: .infinity)
                entryList
                urlList
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
        }
    }

    var nameCard: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    Image(systemName: "hexagon")
                        .symbolVariant(.fill)
                        .foregroundColor(.blue)
                        .font(.system(size: 200))
                        .offset(x: -50, y: -100)
                )
            Text("Hank Hogan")
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text("California, USA")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }

    var entryList: some View {
        Section {
            entry(destination: ContentView(), label: "Settings", systemImage: "gear")
            entry(destination: FuckView(), label: "Billing", systemImage: "creditcard")
            entry(destination: MemorizeView(viewModel: EmojiMemoryGame()), label: "Help", systemImage: "questionmark")
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }

    var urlList: some View {
        Section {
            Link(destination: URL(string: "https://github.com/Kernelize")!) {
                HStack {
                    Label("Homepage", systemImage: "house")
                    Spacer()
                    Image(systemName: "link")
                }
            }
        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }

    func entry(destination: some View, label: String, systemImage: String) -> some View {
        NavigationLink(destination: destination) {
            Label(label, systemImage: systemImage)
        }
    }

}

#Preview {
    AccountView()
}
