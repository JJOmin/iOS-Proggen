//
//  ContentView.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 27.10.23.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var showToast: Bool = false
    
    var body: some View {
        VStack{
            Text("Game of Set").font(.title)
            Text("Cards Left: \(viewModel.cards.count)")
            Text("Score: \(viewModel.getScore)")
            Text("Possible Matches:\(viewModel.possibleMatches)")
            AspectVGrid(items: viewModel.onScreenCards, aspectRatio: 2/3, content: {card in
                CardView(card: card)
                    .padding(2)
                    .foregroundColor(Color(card.content.shapeColor))
                    .onTapGesture {
                        viewModel.choose(card)
                        
                    }
            })
            
            Spacer()
            HStack(spacing: 45) {
                Button(action: {
                    viewModel.helpingHandToggle()
                }) {
                    VStack {
                        Image(systemName: "rectangle.and.hand.point.up.left.filled").font(.largeTitle)
                        Text("Helping Hand")
                    }
                }
                
                Button(action: {
                    viewModel.replaceMatchedCards()
                
                }) {
                    VStack {
                        if viewModel.numberOfCardsShown < viewModel.cards.count{
                            Image(systemName: "rectangle.stack.badge.plus").font(.largeTitle)
                            Text("+3 Cards")
                        } else{
                            Image(systemName: "rectangle.stack.badge.plus").font(.largeTitle)
                            Text("+3 Cards")
                            
                        }
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
            
            
            if showToast && viewModel.getPopupString != ""{
                Text("\(viewModel.getPopupString)")
                    .background(Color.orange).opacity(0.95)
                    .foregroundColor(Color.black)
                    .cornerRadius(15)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showToast = false
                            }
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
