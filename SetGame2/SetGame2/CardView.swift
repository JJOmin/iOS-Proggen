//
//  CardView.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 28.10.23.
//

import SwiftUI

struct CardView: View {
    let card: Model<ViewModel.CardContent>.Card
    let scalingFactor: Double = 1

    var body: some View {
        GeometryReader(content: {geometry in
            ZStack {
                if card.isSelected && card.isMatched == .notChecked {
                    createShapeAndContent(borderColor: .orange, backgroundColor: .orange, geometry: geometry)
                } else if card.isMatched == .trueMatch && card.isSelected {
                    createShapeAndContent(borderColor: .indigo, backgroundColor: .indigo,geometry: geometry)
                }else if card.isMatched == .falseMatch && card.isSelected {
                    createShapeAndContent(borderColor: .gray, backgroundColor: .red,geometry: geometry)
                }else if card.isSelected == false && card.isHelpingHand{
                    createShapeAndContent(borderColor: .gray, backgroundColor: .gray,geometry: geometry)
                }else{
                    createShapeAndContent(borderColor: .gray, backgroundColor: .white,geometry: geometry)
                }
                
                //-----------------Abfrage für Shapes:-----------------
                if card.content.shapeName == "Rectangle"{
                    Rectangle(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity,
                        width: (geometry.size.width/DrawingConstants.rectScalingFactor)-DrawingConstants.borderFactor,
                        height: (geometry.size.width/DrawingConstants.rectScalingFactor)-DrawingConstants.borderFactor,
                        amount: card.content.shapeAmount,
                        spacing: geometry.size.width/DrawingConstants.spacingFactor)
                } else if card.content.shapeName == "Pill"{
                    Pill(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity,
                        width: geometry.size.width/DrawingConstants.pillScalingFactor,
                        height: geometry.size.width/DrawingConstants.pillScalingFactor, 
                        amount: card.content.shapeAmount,
                        spacing: geometry.size.width/DrawingConstants.spacingFactor)
                    
                }else if card.content.shapeName == "Diamond"{
                    Diamond(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity,
                        width: geometry.size.width/DrawingConstants.diamondScalingFactor,
                        height: geometry.size.width/DrawingConstants.diamondScalingFactor,
                        amount: card.content.shapeAmount,
                        spacing: geometry.size.width/DrawingConstants.spacingFactor)
                }
                //--------------------------------------------------------
            }
        })
    }
    private func createShapeAndContent(borderColor: Color,backgroundColor: Color, geometry: GeometryProxy) -> some View{
        let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill()
        
        return cardShape
            .foregroundColor(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.width/DrawingConstants.cornerRadius)
                    .strokeBorder(borderColor, lineWidth: geometry.size.width/DrawingConstants.lineWidth))
    }
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 15
        static let rectScalingFactor: CGFloat = 3.5
        static let pillScalingFactor: CGFloat = 1.5
        static let diamondScalingFactor: CGFloat = 3.3
        static let spacingFactor: CGFloat = 10
        static let borderFactor: CGFloat = 0
        
    }
}
