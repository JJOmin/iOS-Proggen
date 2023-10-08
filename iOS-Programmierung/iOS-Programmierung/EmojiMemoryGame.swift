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

class EmojiMemoryGame{
    static let emojis = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"]
    
    static func createMemoryGame() ->MemoryGame<String>{
            return MemoryGame<String>(numberOfPairsOfCards: 4) {pairIndex in
                emojis[pairIndex]
        }
    
    }
    private var model: MemoryGame<String> = createMemoryGame()
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
}
