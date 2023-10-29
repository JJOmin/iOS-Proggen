//
//  ContentView.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 27.10.23.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack{
            Text("Game of Set").font(.title)
            HStack{
                Text("Score: \(viewModel.getScore)")
                
                //Text("PossiblePairs: \(viewModel.getPossiblePairs)")
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(0..<viewModel.numberOfCardsShown, id: \.self) { index in
                        let card = viewModel.cards[index]
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fill)
                            .foregroundColor(Color(card.content.shapeColor))
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                .padding(1)
            }
            
            HStack(spacing: 45) {
                Button(action: {
                    //viewModel.createNewSetGame()
                    
                }) {
                    VStack {
                        Image(systemName: "rectangle.and.hand.point.up.left.filled").font(.largeTitle)
                        Text("Helping Hand")
                    }
                }
                
                Button(action: {
                    //viewModel.createNewSetGame()
                }) {
                    VStack {
                        Image(systemName: "rectangle.stack.badge.plus").font(.largeTitle)
                        Text("+3 Cards")
                    }
                }
                Button(action: {
                    viewModel.createNewSetGame()
                }) {
                    VStack {
                        Image(systemName: "plus.rectangle.fill").font(.largeTitle)
                        Text("New Game")
                    }
                }
                
                
            }
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
