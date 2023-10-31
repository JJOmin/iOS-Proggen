//
//  CardView.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 28.10.23.
//

import SwiftUI

struct CardView: View {
    let card: Model<ViewModel.CardContent>.Card
    let scalingFactor: Double

    var body: some View {
        GeometryReader(content: {geometry in
            
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: 15*scalingFactor+5).fill()
                
                if card.isSelected && !card.isMatched {
                    cardShape
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15*scalingFactor+3)
                                .strokeBorder(.orange, lineWidth: 6))
                } else if card.isMatched && card.isSelected {
                    cardShape
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15*scalingFactor+3)
                                .strokeBorder(.indigo, lineWidth: 8))
                }else{
                    cardShape
                        .foregroundColor(.white) // Hintergrundfarbe der Karte
                        .overlay(
                            RoundedRectangle(cornerRadius: 15*scalingFactor+3)
                                .strokeBorder(.black, lineWidth: 4))
                }
                
                //-----------------Abfrage für Shapes:-----------------
                if card.content.shapeName == "Rectangle"{
                    Rectangle(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 30*scalingFactor, height: 30*scalingFactor, amount: card.content.shapeAmount)
                } else if card.content.shapeName == "Pill"{
                    Pill(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 50*scalingFactor, height: 50*scalingFactor, amount: card.content.shapeAmount)
                    
                }else if card.content.shapeName == "Diamond"{
                    Diamond(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 30*scalingFactor, height: 30*scalingFactor, amount: card.content.shapeAmount)
                }
                //--------------------------------------------------------
            }
        })
    }
}
