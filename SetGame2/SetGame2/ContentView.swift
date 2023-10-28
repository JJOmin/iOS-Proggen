//
//  ContentView.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 27.10.23.
//

import SwiftUI
struct ContentView: View {
    let viewModel: ViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                for i in 0..<viewModel.numberOfCardsInGame{
                    let card = viewModel.cards[i]
                    print(card.id,card.content.shapeName, card.content.shapeColor, card.content.shapeAmount, card.content.shapeOpacity)
                    
                    /*
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fill)
                        .foregroundColor(Color(card.content.shapeColor))
                    */
                }
            }
            .padding(1)
        }
    }
}

struct CardView: View {
    let card: Model<ViewModel.CardContent>.Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill()
                .foregroundColor(.white)
        }
    }
}

// ViewModel und Model Definitionen bleiben unverändert


struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        let set = ViewModel()
        ContentView(viewModel: set).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        ContentView(viewModel: set).preferredColorScheme(.light)
    }
}
