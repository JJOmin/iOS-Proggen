//
//  ContentView.swift
//  MemoryGameLecture
//
//  Created by Leonhard Tilly on 20.10.23.
// Views has so listen to ViewModel publishing changes
//User Interaktions "send" to the ViewModel

import SwiftUI

struct ContentView: View {
    @ObservedObject var accViewModel: ViewModel //Zugriff
    
    var body: some View {

            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(accViewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                accViewModel.choose(card)
                            }
                    }
                }
            }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

struct CardView: View{
    let card: Model<String>.Card //Zugriff auf eine Card aus Model & passing only card
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle).padding()
            }else if card.isMatched{
                shape.opacity(0) //makes the matched Cards Invisible
            } else {
                shape.fill()
            }
        }
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        let  game = ViewModel()
        ContentView(accViewModel: game).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        ContentView(accViewModel: game).preferredColorScheme(.light)
    }
    
}
