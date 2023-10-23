//Lecture 3 Done
//Lecture 4 Done
//Lecture 5 000 - Themes fertig, 
//  Model.swift
//  MemoryGameLecture
//
//  Created by Leonhard Tilly on 20.10.23.
//Storing Data and get changed fromn the ViewModel
//

import Foundation
struct Model<CardContent> where CardContent: Equatable{ //"where CardContent: Equatable" ermöglicht vergleich von "cards[chosenIndex].content == cards[potentialMatchIndex].content"
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? //Saves only card up & trys to macht the other Upside Card
    private(set) var score: Int = 0 //var for the Score
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), //start if
           !cards[chosenIndex].isFaceUp, //dont allow FaceUpCards to turnd back down
           !cards[chosenIndex].isMatched { //dont allow to turn already matched cards
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                
                //erweiterung
                cards[potentialMatchIndex].alreadySeeCount += 1
                cards[chosenIndex].alreadySeeCount += 1
                //
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true //setzt wert der card auf matched
                    cards[potentialMatchIndex].isMatched = true //""
                    score += 2
                }else if cards[chosenIndex].alreadySeeCount > 1 && cards[potentialMatchIndex].alreadySeeCount > 1{ //Wenn beider Karten schon min 1x gesehen
                    score -= 2
                } else if cards[chosenIndex].alreadySeeCount > 1 || cards[potentialMatchIndex].alreadySeeCount > 1 { //wenn eine der beiden Karten schon gesehen wurde
                    score -= 1
                }
            indexOfTheOneAndOnlyFaceUpCard = nil //set the only face up card to nil
            
        } else{ //if the second card is not matched to the first card, then turn all cards faceDown
            for index in 0..<cards.count { //all Cards
                cards[index].isFaceUp = false //faceDown
                }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
        cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    
    //Initalizer
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
            cards = Array<Card> ()
            for pairIndex in 0 ..< numberOfPairsOfCards {
                let content: CardContent = createCardContent (pairIndex)
                cards.append (Card(content: content,id: pairIndex*2))
                cards.append (Card(content: content, id : pairIndex*2+1))
            }
            cards.shuffle()
            score = 0
            // add number0fPairsOfCards × 2 cards to cards array
        }
    
    struct Card: Identifiable {
        //Outside Name "Model.Card"
        var alreadySeeCount = 0
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // Dont Care Type (have to be anounced in struct)
        var id: Int
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    func getScore() -> Int{
        return self.score
    }
}

