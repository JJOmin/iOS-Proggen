//
//  ViewModel.swift
//  MemoryGameGuidedLecture
//
//  Created by Leonhard Tilly on 20.10.23.
//

import SwiftUI

class ViewModel: ObservableObject {
    typealias Card = SetGame<String>.Card
    
    static let emojis = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"]
    
    private func createSetGame() -> SetGame<String>{
        SetGame<String> (numberOfPairsOfCards: 6) {pairIndex in
            emojis[pairIndex]}
    }
    
    
    @Published private var model: SetGame<String> = createSetGame()
    
    var cards Array<Card> {
        return model.cards
    }
    

    //MARK: -Intent(s)
    
    func choose(_ card: SetGame<String>.Card) {
        model.choose(card: card)

    }
    

}
