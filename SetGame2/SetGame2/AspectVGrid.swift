//
//  AspectVGrid.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 03.11.23.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items:[Item]
    var aspectRatio: CGFloat
    var content:(Item) -> ItemView
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ScrollView{
                    
                    //let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                    let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio, minimumWidth: 35)
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0){
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                        
                    }
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }}
        }
    }
    private func adaptiveGridItem(width : CGFloat)-> GridItem{
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func minimumWidthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat, minimumWidth: CGFloat) -> CGFloat {
        
        var minimumWidth: CGFloat = minimumWidth
        
        for r in stride(from: 2, through: itemCount-1, by:+3){
            if widthThatFits(itemCount: r, in: size, itemAspectRatio: itemAspectRatio, minimumWidth: 34) > minimumWidth{
                minimumWidth = widthThatFits(itemCount: r, in: size, itemAspectRatio: itemAspectRatio, minimumWidth: 34)
                
            }else{
                break
            }
        } 
        return floor(minimumWidth)
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
/*
#Preview {
    AspectVGrid()
}
*/
