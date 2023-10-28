//
//  CardView.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 28.10.23.
//

import SwiftUI

struct CardView: View {
    let card: Model<ViewModel.CardContent>.Card

    var body: some View {
        
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 15).fill()
            
            if card.isSelected {
                cardShape
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.orange, lineWidth: 4))
            } else{
                cardShape
                    .foregroundColor(.white) // Hintergrundfarbe der Karte
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.black, lineWidth: 4))
            }
            
            //-----------------Abfrage für Shapes:-----------------
            if card.content.shapeName == "Rectangle"{
                Rectangle(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 30, height: 30, amount: card.content.shapeAmount)
            } else if card.content.shapeName == "Pill"{
                Pill(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 50, height: 50, amount: card.content.shapeAmount)
                
            }else if card.content.shapeName == "Diamond"{
                Diamond(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 30, height: 30, amount: card.content.shapeAmount)
            }
            //--------------------------------------------------------
        }
    }
}
