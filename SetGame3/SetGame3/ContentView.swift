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
            Text("Possible Matches: \(viewModel.possibleMatches)")
            Text("Cards Left: \(viewModel.cardsLeft.count)")
            Text("Score: \(viewModel.getScore)")
            
            AspectVGrid(items: viewModel.cardsOnScreen, aspectRatio: 2/3, content: {card in
                CardView(card: card)
                    .padding(2)
                    .foregroundColor(Color(card.content.shapeColor))
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            })
            
            /*
             AspectVGrid(items: viewModel.matchedCards, aspectRatio: 2/3, content: {card in
             CardView(card: card)
             //.padding(2)
             .foregroundColor(Color(card.content.shapeColor))
             .onTapGesture {
             print("Here")
             }
             })
             ZStack{
             ForEach(viewModel.matchedCards){ card in
             CardPileView(card: card)
             .padding(2)
             .foregroundColor(Color(card.content.shapeColor))
             .aspectRatio(2/3, contentMode: .fit)
             .onTapGesture {
             print("Test")
             }}
             }
             CardPileView(card: viewModel.cards2[viewModel.lastMatchedCard])
             .padding(2)
             //.foregroundColor(Color(card.content.shapeColor))
             .onTapGesture {
             print("Test")
             }*/
            
            
            
            Spacer()
            HStack(spacing: 30) {
                
                 Button(action: {
                 }) {
                     ZStack {
                         ForEach(viewModel.matchedCards){ card in
                             CardPileView(card: card, faceUp: true)
                                 .padding(2)
                                 .foregroundColor(Color(card.content.shapeColor))
                                 .aspectRatio(2/3, contentMode: .fit)
                                 .frame(width: 60)
                                 .onTapGesture {
                                     print("Test")
                                 }}
                     }
                 }
                Button(action: {
                    if viewModel.numberOfCardsShown < 21{
                        viewModel.helpingHandToggle()
                        if viewModel.possibleMatches == 0{
                            viewModel.helpingHandToggle()
                        }
                    }
                }) {
                    VStack {
                        if viewModel.helpingHandState == true{
                            Image(systemName: "rectangle.and.hand.point.up.left.filled").font(.largeTitle).foregroundColor(.yellow)
                            Text("Helping Hand").foregroundColor(.yellow)
                        } else if viewModel.numberOfCardsShown >= 21 || viewModel.possibleMatches == 0{
                            Image(systemName: "rectangle.and.hand.point.up.left.filled").font(.largeTitle).foregroundColor(.gray).opacity(0.5)
                            Text("Helping Hand").foregroundColor(.gray).opacity(0.5)
                        }else{
                            Image(systemName: "rectangle.and.hand.point.up.left.filled").font(.largeTitle).foregroundColor(.blue)
                            Text("Helping Hand").foregroundColor(.blue)
                            
                        }
                    }
                }
                /*
                Button(action: {
                                    viewModel.addThreeCards()
                                
                }) {
                    VStack {
                        if viewModel.numberOfCardsShown < viewModel.cards.count{
                            Image(systemName: "rectangle.stack.badge.plus").font(.largeTitle).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text("+3 Cards").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        } else{
                            Image(systemName: "rectangle.stack.badge.plus").font(.largeTitle).foregroundColor(.gray).opacity(0.5)
                            Text("+3 Cards").foregroundColor(.gray).opacity(0.5)
                        }
                    }
                    
                }
                */
                
                Button(action: {
                    viewModel.createNewSetGame()
                }) {
                    VStack {
                        Image(systemName: "plus.rectangle.fill").font(.largeTitle)
                        Text("New Game")
                    }
                }
                
                
                
                Button(action: {
                    viewModel.addThreeCards()
                }) {
                    ZStack {
                        ForEach(viewModel.notPlayedCards){ card in
                            CardPileView(card: card, faceUp: false)
                                .padding(2)
                                .foregroundColor(Color(card.content.shapeColor))
                                .aspectRatio(2/3, contentMode: .fit)
                                .frame(width: 60)
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
}
















// ViewModel und Model Definitionen bleiben unverändert
struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        let set = ViewModel()
        ContentView(viewModel: set).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        ContentView(viewModel: set).preferredColorScheme(.light)
    }
}
