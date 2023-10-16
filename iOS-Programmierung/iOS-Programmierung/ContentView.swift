//
//  ContentView.swift
//
//  Created by Leonhard Tilly on 28.09.23.
//Lecture 4 19:00
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    //@State var themeTitle = "Fruity Memory Game"
    
    var body: some View {
        VStack{
            Text(viewModel.getThemeName())
                .font(.largeTitle)
            HStack{
                Text("Score:")
                Text(String(viewModel.getScore()))
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
                }.foregroundColor(viewModel.getCardColor).font(.largeTitle)
                   
            }
            Spacer()
            
            HStack{
                buttonForSomething
                Spacer()
                shuffle
            }
        }
        .padding(.horizontal)
    }
    
    var buttonForSomething :some View{
        Button(action: {
            viewModel.createNewMemoryGame()}
               , label: {
            VStack{
                Image(systemName: "gamecontroller").font(.largeTitle)
                Text("New Game")
            }
        })
    }
    
    
    var shuffle :some View{
        Button(action: {
            viewModel.shuffle()}
               , label: {
            VStack{
                Image(systemName: "shuffle.circle").font(.largeTitle)
                Text("shuffle")}})
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    let color: Color
    var body: some View {
        
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 25.0)
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
