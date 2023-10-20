//
//  ContentView.swift
//  MemoryGameGuidedLecture
//
//  Created by Leonhard Tilly on 19.10.23.
//Lecture 1 1:11:30

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: viewModel
    
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: {
            card in cardView(for: card)
        })
        .forground(.orange)
        .padding(.horizontal)
        
        @ViewBuilder
        private func cardView(for card :viewModel.Card)-> some View{
            Rectabgle().opacity(0)
        }else{
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
    
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    let color: Color
    var body: some View {
        
        ZStack{
            let shape :RoundedRectangle = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp{
                
                shape.fill()
                shape.foregroundColor(color)
                RoundedRectangle(cornerRadius: 22.0)
                    .strokeBorder(lineWidth: 3.0)
                Text(card.content)
                    .font(.largeTitle)
            }else if card.choosen {
                shape.strokeBodrder(lineWidth: 5)
                    .forgroundColor(.blue)
                
            }
        }
    }
}








//Settings for Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
