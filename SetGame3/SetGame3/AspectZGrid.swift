//
//  AspectVGrid.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 03.11.23.
//

import SwiftUI

struct AspectZGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items:[Item]
    var aspectRatio: CGFloat
    var content:(Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    
    var body: some View {
        GeometryReader{ geometry in
           
            LazyVGrid(columns: [adaptiveGridItem(width: 40)], spacing: 0){
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
        }
    }
    
    
    private func adaptiveGridItem(width : CGFloat)-> GridItem{
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat, minimumWidth: CGFloat) -> CGFloat{
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat (rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        }
        
        while columnCount < itemCount
                if columnCount > itemCount {
            columnCount = itemCount
        }
        if floor(size.width / CGFloat (columnCount) ) < minimumWidth{
            return minimumWidth
        }else{
            return floor(size.width / CGFloat (columnCount) )
        }
    }
}
