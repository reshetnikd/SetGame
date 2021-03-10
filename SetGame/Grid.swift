//
//  Grid.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 10.03.2021.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                let layout = GridLayout(itemCount: items.count, nearAspectRatio: 2/3, in: geometry.size)
                let index = { () -> Int? in
                    for index in 0..<items.count {
                        if items[index].id == item.id {
                            return index
                        }
                    }
                    return nil
                }()!
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}
