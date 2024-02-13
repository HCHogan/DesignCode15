//
//  MyNaviView.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct MyNaviView: View {
    @State var isScroll = false
    @State private var showAccountView = false
    @State private var loggedIn = false

    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                Color.clear.preference(key: ScrollPreKey.self, value: proxy.frame(in: .named("scroll")).minY)
            }
            ForEach(0..<15) { index in
                InfoCardView()
            }
        }
        .overlay {
            if !loggedIn {
                ContentUnavailableView.search
                    .background()
            }
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollPreKey.self) { value in
            withAnimation(.easeInOut(duration: 0.2)) {
                if value < 0 {
                    isScroll = true
                } else {
                    isScroll = false
                }
            }
        }
        .safeAreaInset(edge: .top) {
            Color.clear
                .frame(height: 30)
        }
        .overlay {
            ZStack {
                Color.clear
                    .frame(height: isScroll ? 90 : 100)
                    .background(.ultraThinMaterial)
                    .opacity(isScroll ? 1 : 0)
                    .blur(radius: 0.5)
                    .edgesIgnoringSafeArea(.top)
                HStack {
                    Text("Home").bold()
                        .font(.system(size: isScroll ? 22 : 32))
                        .padding(.bottom, 10)
                    Spacer()
                    Button {
                        showAccountView.toggle()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(isScroll ? .title : .largeTitle)
                            .padding(.bottom, 10)
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: $showAccountView) {
                        AccountView()
                    }
                }
                .offset(y: isScroll ? -30 : -25)
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct InfoCardView : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundColor(Color(red: 240 / 255, green: 243 / 255, blue: 253 / 255))
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
            .padding()
            .overlay {
                VStack(alignment: .leading) {
                    Circle()
                        .frame(width:50, height: 50)
                        .overlay(
                            Image(systemName: "text.book.closed.fill")
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .font(.title2)
                    )
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .frame(width: 100, height: 25)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .frame(width: 250, height: 15)
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .frame(width: 200, height: 15)
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .frame(width: 290, height: 15)

                    }
                    .foregroundColor(.gray.opacity(0.5))
                }
            }
    }
}

struct ScrollPreKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    MyNaviView()
}
