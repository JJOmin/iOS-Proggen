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
        
        ZStack {
            VStack{
                Text("Game of Set").font(.title)
                Text("Cards On Screen: \(viewModel.numberOfCardsShown)")
                HStack{
                    Text("Score: \(viewModel.getScore)")
                    
                    //Text("PossiblePairs: \(viewModel.getPossiblePairs)")
                }
                Spacer()
                HStack {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: viewModel.gridSizeCalculator()), spacing: 5)
                        ], spacing: 10) {
                        ForEach(0..<viewModel.numberOfCardsShown, id: \.self) { index in
                            let card = viewModel.cards[index]
                            CardView(card: card, scalingFactor: viewModel.scalingFactor)
                                .aspectRatio(2/3, contentMode: .fit)
                                .foregroundColor(Color(card.content.shapeColor))
                                .onTapGesture {
                                    viewModel.choose(card)
                                    showToast.toggle()
                                }
                        }
                    }
                    .padding(1)
                }
                Spacer()
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
                        viewModel.addCardsShown()
                        showToast.toggle()
                        //viewModel.gridSizeCalculator()
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
            VStack {
                if showToast && viewModel.getPopupString != ""{
                    Text("\(viewModel.getPopupString)")
                        .padding()
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
