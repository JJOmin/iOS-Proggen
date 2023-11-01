import Foundation
import SwiftUI

// Model
struct Model<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var numberOfCardsInGame: Int
    var numberOfCardsShown: Int
    private(set) var score: Int
    //private(set) var reactingString: String
    private(set) var numberOfPossiblePairs: Int
    private(set) var getPopupString: String
    var gridSize: CGFloat
    var scalingFactor: Double
    var startMatching = 0
    var deselecting: Int
    var placeholder: Int
    var helpingHandState: Bool
    
    private var selectedCardIds: Array<Int> {
        get{
            return cards.indices.filter({cards[$0].isSelected}).selected}
        set{
            return cards.indices.forEach{ cards[$0].isSelected = false}
        }
    }
    
    private var matchedCardIds: Array<Int>? {
        var matchedCardIndecies = [Int]()
        for index in cards.indices{
            //Wenn gematcht
            if cards[index].isMatched2 == .trueMatch {
                matchedCardIndecies.append(index)
            }
        }
        
        if matchedCardIndecies.count == 1{
            return [matchedCardIndecies[0]]
        } else if matchedCardIndecies.count == 2{
            var cardArray = [Int]()
            cardArray.append(matchedCardIndecies[0])
            cardArray.append(matchedCardIndecies[1])
            return cardArray //cardArray
        } else if matchedCardIndecies.count == 3{
            var cardArray = [Int]()
            cardArray.append(matchedCardIndecies[0])
            cardArray.append(matchedCardIndecies[1])
            cardArray.append(matchedCardIndecies[2])
            return cardArray //cardArray
        } else {
            return nil
        }
    }
    
    
    var database = Database() //Zugriff auf die Database
    
    init(totalNumberOfCards: Int, numCardsShown: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        //selectedCardIds = []
        numberOfCardsInGame = totalNumberOfCards
        numberOfCardsShown = numCardsShown
        score = 0
        //reactingString = " "
        numberOfPossiblePairs = 0
        getPopupString = ""
        gridSize = 94
        scalingFactor = 1
        deselecting = 0
        placeholder = 0
        helpingHandState = false
        
        
        for i in 0..<totalNumberOfCards {
            let content: CardContent = createCardContent(i)
            let card = Card(id: i+1, content: content, isMatched2: .notChecked)
            cards.append(card)
        }
    }
    
    struct Card: Identifiable, Equatable {
        var id: Int
        var isSelected = false
        var isMatched = false
        var content: CardContent
        var isMatched2: MatchStatus
        enum MatchStatus {
            case trueMatch
            case falseMatch
            case notChecked
        }
    }
    
    mutating func addCardsShown(){
        if numberOfCardsShown <= cards.count-3{
            numberOfCardsShown += 3
        } else {
            getPopupString = "All Cards are Shown!"
        }
    }
    
    
    
    
    mutating func choose (_ card: Card) {
        
        //De/Selecting Cards
        if !card.isSelected && (card.isMatched2 == .falseMatch || card.isMatched2 == .notChecked) { //&& card.isMatched == false //nicht ausgewählt und nicht gematcht (notChecked + .falseMatched)
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = true
                deselecting += 1
                
            }
        } else if card.isSelected == true && (card.isMatched2 == .notChecked) {
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = false
                deselecting -= 1
                
            }
        }
        
        //Code to test if something sould be testet for match
        if selectedCardIds.count == 3{
            //print("Matching starts:\(selectedCardIds[0])\(selectedCardIds[1])\(selectedCardIds[2])")
            let selectedCard1 = cards[selectedCardIds[0]]
            let selectedCard2 = cards[selectedCardIds[1]]
            let selectedCard3 = cards[selectedCardIds[2]]
            //print(selectedCard1)
            //print(selectedCard2)
            //print(selectedCard3)
            
            if let card1 = selectedCard1.content as? ViewModel.CardContent, let card2 = selectedCard2.content as? ViewModel.CardContent, let card3 = selectedCard3.content as? ViewModel.CardContent{
                
                //wenn es ein set ist, dann setze matched status bei allen carten die matchen
                if isValidSet(card1: card1, card2: card2, card3: card3){
                    
                    //zum sicherstellen das nicht
                    if cards[selectedCardIds[0]].isMatched2 == .falseMatch || cards[selectedCardIds[0]].isMatched2 == .notChecked || cards[selectedCardIds[1]].isMatched2 == .falseMatch || cards[selectedCardIds[1]].isMatched2 == .notChecked || cards[selectedCardIds[2]].isMatched2 == .falseMatch || cards[selectedCardIds[2]].isMatched2 == .notChecked {
                        cards[selectedCardIds[0]].isMatched2 = .trueMatch
                        cards[selectedCardIds[1]].isMatched2 = .trueMatch
                        cards[selectedCardIds[2]].isMatched2 = .trueMatch
                        //print(cards[selectedCardIds[0]])
                        //print(cards[selectedCardIds[1]])
                        //print(cards[selectedCardIds[2]])
                        score += 3
                        
                    }
                    
                } else {
                    //print(selectedCardIds[0]
                    //print("Not a set")
                    cards[selectedCardIds[0]].isMatched2 = .falseMatch
                    cards[selectedCardIds[1]].isMatched2 = .falseMatch
                    cards[selectedCardIds[2]].isMatched2 = .falseMatch
                    //deselecting = 3
                }
            }
        }
        if deselecting == 4{
            //print("Gucken wir mal ob ich doch noch entfernen kann:\(matchedCardIds) \(selectedCardIds)")
            //Deselects all cards exept the las one
            for i in cards.indices {
                if let fourthCardIndex = cards.firstIndex(where: { $0.id == card.id }){
                    if i != fourthCardIndex{
                        cards[i].isSelected = false
                        if cards[i].isMatched2 != .trueMatch{
                            cards[i].isMatched2 = .notChecked
                        }
                    }
                }

            }
            for _ in 0..<3{
                for (index, element) in cards.enumerated() {
                    if element.isMatched2 == .trueMatch {
                        cards.remove(at: index)
                    }
                }
            }
            if selectedCardIds.count == 1 && matchedCardIds == nil{
                deselecting = 1
                
            }
            
        }
       
    }
    func isValidSet(card1: ViewModel.CardContent, card2: ViewModel.CardContent, card3: ViewModel.CardContent) -> Bool{
        //Color different
        let colorIsvalid = (card1.shapeColor == card2.shapeColor && card2.shapeColor == card3.shapeColor) || (card1.shapeColor != card2.shapeColor && card2.shapeColor != card3.shapeColor)
        //Amount
        let amountIsvalid = (card1.shapeAmount == card2.shapeAmount && card2.shapeAmount == card3.shapeAmount) || (card1.shapeAmount != card2.shapeAmount && card2.shapeAmount != card3.shapeAmount)
        //ShapeName
        let shapeNameIsvalid = (card1.shapeName == card2.shapeName && card2.shapeName == card3.shapeName) || (card1.shapeName != card2.shapeName && card2.shapeName != card3.shapeName)
        //Opacity
        let opacityIsvalid = (card1.shapeOpacity == card2.shapeOpacity && card2.shapeOpacity == card3.shapeOpacity) || (card1.shapeOpacity != card2.shapeOpacity && card2.shapeOpacity != card3.shapeOpacity)
        
        return colorIsvalid && amountIsvalid && shapeNameIsvalid && opacityIsvalid
    }
    
    //Function that shows (alt least on) solutions for the current Cards on Screen
    func helpingHand() -> [[Card.ID]] {
        var validSets: [[Card.ID]] = []

        for i in 0..<numberOfCardsShown {
            for j in (i+1)..<numberOfCardsShown {
                for k in (j+1)..<numberOfCardsShown {
                    let checkingCard1 = cards[i]
                    let checkingCard2 = cards[j]
                    let checkingCard3 = cards[k]
                    if let card1 = checkingCard1.content as? ViewModel.CardContent, let card2 = checkingCard2.content as? ViewModel.CardContent, let card3 = checkingCard3.content as? ViewModel.CardContent{
                        if isValidSet(card1: card1, card2: card2, card3: card3) {
                            validSets.append([cards[i].id, cards[j].id, cards[k].id])
                        }
                    }
                }
            }
        }
        return validSets
    }
}




extension Array{
    var selected: Array<Int>{
        if self.count == 1{
            return [self[0] as! Int]
        } else if self.count == 2{
            var cardArray = [Int]()
            cardArray.append(self[0] as! Int)
            cardArray.append(self[1] as! Int)
            return cardArray //cardArray
        } else if self.count == 3{
            var cardArray = [Int]()
            cardArray.append(self[0] as! Int)
            cardArray.append(self[1] as! Int)
            cardArray.append(self[2] as! Int)
            return cardArray //cardArray
        } else {
            let cardArray = [Int]()
            return cardArray
        }
        
    }
}
