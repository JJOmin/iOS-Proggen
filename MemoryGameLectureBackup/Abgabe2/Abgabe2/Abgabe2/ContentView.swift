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
            LazyVGrid(columns: [GridItem(.adaptive (minimum: 65))], content: {
                
                ForEach(accViewModel.cards, content: {card in CardView(card: card,color: accViewModel.getPrimaryColor()).aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            accViewModel.choose(card)
                        }
                        .padding(1) // der Abstand zwischen den Cards
                })
            }).foregroundColor(accViewModel.getPrimaryColor())
        }
        Spacer()
        // Button
        HStack{
            newGameButton
            
        }
    }
    var newGameButton :some View {
        Button(action: {
            accViewModel.createMemoryGame()}
               , label: {
            VStack{
                Image(systemName: "plus.rectangle.fill").font(.largeTitle)
                Text("New Game")}})
    }
    
    

}



    
    


struct CardView: View{
    let card: Model<String>.Card //Zugriff auf eine Card aus Model & passing only card
    let color: Color
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle).padding() //fixes the jumping of Cards
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
