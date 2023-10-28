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
            RoundedRectangle(cornerRadius: 15)
                .fill()
                .foregroundColor(.white) // Hintergrundfarbe der Karte
            
            if card.content.shapeName == "Rectangle"{
                Rectangle(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 30, height: 30, amount: card.content.shapeAmount)
            } else if card.content.shapeName == "Pill"{
                Pill(primaryColor: card.content.shapeColor, opacity: card.content.shapeOpacity, width: 50, height: 50, amount: card.content.shapeAmount)
                
            }else if card.content.shapeName == "Diamond"{
                Diamond().frame(width: 40, height: 40)
                    .foregroundColor(card.content.shapeColor)
                    .opacity(card.content.shapeOpacity)
                    
                
            }
            else {
                Text("\(card.content.shapeName)").foregroundColor(card.content.shapeColor) // Textfarbe
                
            }
        }
    }
}
