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
    private(set) var changedScore: String //Var die die Änderung als String speichert
    
    
    mutating func choose(card: Card) {
        // Überprüfen, ob die ausgewählte Karte gültig ist
        changedScore = "0"
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            // Überprüfen, ob bereits eine Karte aufgedeckt wurde
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                cards[potentialMatchIndex].alreadySeenCount += 1
                cards[chosenIndex].alreadySeenCount += 1
                changedScore = "0"
                
                // Überprüfen, ob die ausgewählte Karte mit der bereits aufgedeckten Karte übereinstimmt
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Karten stimmen überein
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                    changedScore = "+2"
                } else {
                    // Karten stimmen nicht überein
                     if cards[chosenIndex].alreadySeenCount > 1 || cards[potentialMatchIndex].alreadySeenCount > 1 {
                        // Wenn eine der Karten bereits mehrmals wurde, Punkte um 2 reduzieren
                         //print("Ausgabe",cards[chosenIndex].alreadySeenCount,cards[potentialMatchIndex].alreadySeenCount)
                        score -= 2
                        changedScore = "-2"
                    } else {
                        // Wenn beide Karten zum ersten Mal gesehen wurdenund nicht übereinstimmen
                        score -= 1
                        changedScore = "-1"
                    }
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // Keine Karte wurde bisher aufgedeckt, also alle umdrehen
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            // Ausgewählte Karte umdrehen und aktuellen Zustand ausgeben
            cards[chosenIndex].isFaceUp.toggle()
            print("\(cards)")
        }
    }
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        //erste schleife
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
        score = 0
        changedScore = "0"
    }
    
    
    struct Card: Identifiable{
        var alreadySeenCount = 0
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    //mischenfunction
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func getScore() ->Int{
        return self.score
    }
    
    func getChangedScore() ->String{
        return self.changedScore
    }
}
