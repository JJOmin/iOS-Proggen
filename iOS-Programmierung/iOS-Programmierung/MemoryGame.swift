//
//  MemoryGame.swift
//  iOS-Programmierung
//
//  Created by Leonhard Tilly on 05.10.23.
//

import Foundation
struct MemoryGame<CardContent>{
    private(set) var cards: Array<Card>
    func choose(_ card:Card){
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        //erste schleife
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
            
        }
    }
    
    
    struct Card{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        
    }
}

