//
//  MemoryGame.swift
//  iOS-Programmierung
//
//  Created by Leonhard Tilly on 05.10.23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var score:Int = 0
    
    mutating func choose(_ card:Card){
        //if let chosenIndex = index(of: card) {
        if let chosenIndex = cards.firstIndex(where:   {$0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                //Erweitert um die Counter
                cards[potentialMatchIndex].alreadySeenCounter +=1
                cards[chosenIndex].alreadySeenCounter +=1
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score +=2
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else{
                for index in 0..<cards.count{
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        //erste schleife
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
        }
    }
    
    
    struct Card: Identifiable{
        
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    //mischenfunction
    mutating func shuffle() {
        cards.shuffle()
    }
}

