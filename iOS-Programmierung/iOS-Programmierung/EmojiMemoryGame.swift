//
//  EmojiMemoryGame.swift
//  iOS-Programmierung
//
//  Created by Leonhard Tilly on 05.10.23.
//

import SwiftUI

func makeCardContent(index: Int) -> String{
    return "🐶"
}

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"]
    
    static func createMemoryGame() ->MemoryGame<String>{
            return MemoryGame<String>(numberOfPairsOfCards: 16) {pairIndex in
                emojis[pairIndex]
        }
    
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: -Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
