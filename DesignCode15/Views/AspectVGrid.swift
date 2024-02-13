//
//  AspectVGrid.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/11.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View 
where
    Item: Identifiable,
    ItemView: View
{
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView

    init(_ items: [Item], aspectRatio: CGFloat = 1, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: items.count, size: geometry.size, atAspectRatio: aspectRatio)
            // let gridItemSize: CGFloat = 65
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                // ForEach creates a bag of Legos
                // we need an id for each element to identify which one is which, need to be unique(hashable)
                // we used id: \.self here, this means the id is the element itself
                ForEach(items) { item in
                    content(item)
                    .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }

    private func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount: CGFloat = 1
        repeat {
            let width = size.width / columnCount
            let height = width / atAspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                print("something1")
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        let res = min(size.width / count, size.height * atAspectRatio).rounded(.down)
        print(count, size, atAspectRatio)
        print("res: \(res), size.width / count: \(size.width / count), size.height * atAspectRatio: \(size.height * atAspectRatio)")
        return res
    }
}
