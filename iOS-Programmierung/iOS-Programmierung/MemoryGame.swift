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
    
    mutating func choose(card: Card) {
        // Überprüfen, ob die ausgewählte Karte gültig ist
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            // Überprüfen, ob bereits eine Karte aufgedeckt wurde
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                cards[potentialMatchIndex].alreadySeeCount += 1
                cards[chosenIndex].alreadySeeCount += 1
                
                // Überprüfen, ob die ausgewählte Karte mit der bereits aufgedeckten Karte übereinstimmt
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Karten stimmen überein
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    // Karten stimmen nicht überein
                    if cards[chosenIndex].alreadySeeCount > 1 && cards[potentialMatchIndex].alreadySeeCount > 1 {
                        // Wenn beide Karten bereits gesehen wurden, Punkte um 2 reduzieren
                        score -= 2
                    } else if cards[chosenIndex].alreadySeeCount > 1 || cards[potentialMatchIndex].alreadySeeCount > 1 {
                        // Wenn eine der Karten bereits gesehen wurde, Punkte um 1 reduzieren
                        score -= 1
                    } else {
                        // Wenn beide Karten zum ersten Mal gesehen wurden, Punkte um 1 erhöhen
                        score += 1
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
    }
    
    
    struct Card: Identifiable{
        var alreadySeeCount = 0
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
}
