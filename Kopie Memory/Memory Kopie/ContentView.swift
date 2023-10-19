//
//  ContentView.swift
//
//  Created by Leonhard Tilly on 28.09.23.
//Lecture 4 19:00
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    @State private var shouldAnimate = false
    //@State var themeTitle = "Fruity Memory Game"
    
    var body: some View {
        VStack{
            Text(viewModel.getThemeName())
                .font(.largeTitle)
            HStack {
                Text("Score:")
                Text(String(viewModel.getScore()))
            
                if viewModel.getChangedScore() != "0" {
                    Text(String(viewModel.getChangedScore()))
                        .opacity(shouldAnimate ? 1 : 0)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5))
                        .onAppear {
                            // Timer für 1 Sekunde Verzögerung
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                                withAnimation {
                                    shouldAnimate = false
                                }
                            }
                            // Animation starten und shouldAnimate auf true setzen
                            withAnimation {
                                shouldAnimate = true
                            }
                        }
                }
            }
        ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.getGroundColor())
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                            .padding(1)
                    }
                }.foregroundColor(viewModel.getCardColor()).font(.largeTitle)
                   
            }
            Spacer()
            
            HStack{
                buttonForSomething
            }
        }
        .padding(.horizontal)
    }
    
    var buttonForSomething :some View{
        Button(action: {
            viewModel.createNewMemoryGame()}
               , label: {
            VStack{
                Image(systemName: "plus.square.fill").font(.largeTitle)
                Text("New Game")
            }.foregroundColor(viewModel.getCardColor())
        })
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
            }else if card.isMatched {
                shape.opacity(0)
                
            } else{
                shape.fill()
            }
        }
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
