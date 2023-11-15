//
//  CardPileView.swift
//  SetGame3
//
//  Created by Leonhard Tilly on 15.11.23.
//

import SwiftUI
struct CardPileView: View {
    let card: Model<ViewModel.CardContent>.Card
    let faceUp: Bool
    let scalingFactor: Double = 1

    var body: some View {
       
            GeometryReader(content: {geometry in
                ZStack {
                    
                        if card.isSelected && card.isMatched == .notChecked && faceUp{
                            createShapeAndContent(borderColor: .mint, backgroundColor: .indigo,backroundOpacity: 1, geometry: geometry)
                        } else if card.isMatched == .trueMatch && card.isSelected && faceUp{
                            createShapeAndContent(borderColor: .mint, backgroundColor: .green,backroundOpacity: 1,geometry: geometry)
                        }else if card.isMatched == .falseMatch && card.isSelected && faceUp{
                            createShapeAndContent(borderColor: .mint, backgroundColor: .red,backroundOpacity: 1,geometry: geometry)
                        }else if card.isSelected == false && card.isHelpingHand && faceUp{
                            createShapeAndContent(borderColor: .yellow, backgroundColor: .gray,backroundOpacity: 1,geometry: geometry)
                        }else if !faceUp{
                            createShapeAndContent(borderColor: .pink, backgroundColor: .gray,backroundOpacity: 1,geometry: geometry)
                        }else{
                            createShapeAndContent(borderColor: .gray, backgroundColor: .white,backroundOpacity: 1,geometry: geometry)
                        }
                    if faceUp{
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
                    }}
            })
                
            
    }
    private func createShapeAndContent(borderColor: Color,backgroundColor: Color, backroundOpacity: CGFloat, geometry: GeometryProxy) -> some View{
        let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill()
        
        return cardShape
            .foregroundColor(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.width/DrawingConstants.cornerRadius)
                    .strokeBorder(borderColor, lineWidth: geometry.size.width/DrawingConstants.lineWidth).opacity(backroundOpacity))
    }
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 15
        static let rectScalingFactor: CGFloat = 3.5
        static let pillScalingFactor: CGFloat = 1.5
        static let diamondScalingFactor: CGFloat = 3.3 //1.8 //3.3
        static let spacingFactor: CGFloat = 10
        static let borderFactor: CGFloat = 0
        
    }
}
