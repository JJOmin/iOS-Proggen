import Foundation
import SwiftUI

// Model
struct Model<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var numberOfCardsShown: Int
    private(set) var score: Int
    private(set) var getPopupString: String
    private(set) var deselecting: Int
    private(set) var helpingHandState: Bool
    private(set) var onScreenCards: Array<Card>
    private(set) var database = Database() //Zugriff auf die Database
    private(set) var somethingMatched: statusMatched
    enum statusMatched {
        case falseMatched
        case trueMatched
        case notChecked
        case removePending
    }
    
    private var selectedCardIds: Array<Int> {
        get{
            return cards.indices.filter({cards[$0].isSelected}).selected}
    }
    
    private var matchedCardIds: Array<Int> {
        var matchedCardIndecies = [Int]()
        for index in cards.indices{
            //Wenn gematcht
            if cards[index].isMatched == .trueMatch {
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
            return [100]
        }
    }
    
    
    
    
    init(totalNumberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        onScreenCards = []
        numberOfCardsShown = 12
        score = 0
        getPopupString = ""
        deselecting = 0
        helpingHandState = false
        somethingMatched = .notChecked
        
        for i in 0..<totalNumberOfCards {
            let content: CardContent = createCardContent(i)
            let card = Card(id: i+1, content: content, isMatched: .notChecked)
            cards.append(card)
            if i < numberOfCardsShown {
                onScreenCards.append(card)
            }
        }
    }
    
    struct Card: Identifiable, Equatable {
        var id: Int
        var isSelected = false
        var isHelpingHand = false
        var content: CardContent
        var isMatched: MatchStatus
        enum MatchStatus {
            case trueMatch
            case falseMatch
            case notChecked
        }
    }
    
    //Mutating funcs
    mutating func addCardsShown(){
        if numberOfCardsShown <= cards.count-3{
            numberOfCardsShown += 3
            
        } else {
            getPopupString = "All Cards are Shown!"
        }
    }
    
    
    mutating func refreshOnScreenCards(){
        onScreenCards = []
        for i in 0..<numberOfCardsShown {
            onScreenCards.append(cards[i])
        }
    }
    
    
    mutating func choose (_ card: Card) {
        //De/Selecting Cards
        if !card.isSelected && (card.isMatched == .falseMatch || card.isMatched == .notChecked) { //&& card.isMatched == false //nicht ausgewählt und nicht gematcht (notChecked + .falseMatched)
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = true
                refreshOnScreenCards()
                deselecting += 1
                print(helpingHand())
                
            }
        } else if card.isSelected == true && (card.isMatched == .notChecked) {
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = false
                refreshOnScreenCards()
                deselecting -= 1
                
            }
        }
        
        //Code to test if something sould be testet for match
        if selectedCardIds.count == 3{
            let selectedCard1 = cards[selectedCardIds[0]]
            let selectedCard2 = cards[selectedCardIds[1]]
            let selectedCard3 = cards[selectedCardIds[2]]
            
            if let card1 = selectedCard1.content as? ViewModel.CardContent, let card2 = selectedCard2.content as? ViewModel.CardContent, let card3 = selectedCard3.content as? ViewModel.CardContent{
                
                //wenn es ein set ist, dann setze matched status bei allen carten die matched
                if isValidSet(card1: card1, card2: card2, card3: card3){
                    
                    if selectedCard1.isMatched == .falseMatch || selectedCard1.isMatched == .notChecked || selectedCard2.isMatched == .falseMatch || selectedCard2.isMatched == .notChecked || selectedCard3.isMatched == .falseMatch || selectedCard3.isMatched == .notChecked {
                        cards[selectedCardIds[0]].isMatched = .trueMatch
                        cards[selectedCardIds[1]].isMatched = .trueMatch
                        cards[selectedCardIds[2]].isMatched = .trueMatch
                        helpingHandState = false
                        setHelpingHand()
                        refreshOnScreenCards()
                        score += 3
                        
                        somethingMatched = .trueMatched
                        
                    }
                } else {
                    cards[selectedCardIds[0]].isMatched = .falseMatch
                    cards[selectedCardIds[1]].isMatched = .falseMatch
                    cards[selectedCardIds[2]].isMatched = .falseMatch
                    helpingHandState = false
                    setHelpingHand()
                    refreshOnScreenCards()
                    somethingMatched = .falseMatched
                }
            }
        }
        if deselecting == 4{
            if somethingMatched == .falseMatched{
                for i in cards.indices{
                    if cards[i].isMatched == .falseMatch{
                        cards[i].isSelected = false
                        cards[i].isMatched = .notChecked
                    }
                    somethingMatched = .notChecked
                }
                refreshOnScreenCards()
                deselecting = 1
                
            } else if somethingMatched == .trueMatched {
                replaceMatchedCards()
                replaceMatchedCards()
                replaceMatchedCards()
                refreshOnScreenCards()
                somethingMatched = .notChecked
                deselecting = 1
                
            }
        }
    }
    
    
    mutating func replaceMatchedCards(){
        if cards[matchedCardIds[0]].isMatched == .trueMatch{
            cards[matchedCardIds[0]] = cards[cards.count-1]
            cards.removeLast()
            if numberOfCardsShown >= cards.count{
                numberOfCardsShown = cards.count-1
            }
            refreshOnScreenCards()
        }
    }
    
    mutating func replaceCardsButton(){
        if somethingMatched == .trueMatched{
            
            cards[matchedCardIds[0]] = cards[cards.count-1]
            cards[matchedCardIds[0]] = cards[cards.count-2]
            cards[matchedCardIds[0]] = cards[cards.count-3]
            cards.removeLast()
            if numberOfCardsShown >= cards.count{
                numberOfCardsShown = cards.count-1
            }
            cards.removeLast()
            if numberOfCardsShown >= cards.count{
                numberOfCardsShown = cards.count-1
            }
            cards.removeLast()
            if numberOfCardsShown >= cards.count{
                numberOfCardsShown = cards.count-1
            }
            refreshOnScreenCards()
            somethingMatched = .notChecked
           
        }
        else{
            addCardsShown()
            refreshOnScreenCards()
        }
    }

    mutating func toggleHelpingHand(){
        helpingHandState.toggle()
        setHelpingHand()
        
    }
    
    
    mutating func setHelpingHand(){
        for i in cards.indices{
            if helpingHandState == true && helpingHandOne.count > 0{
                if i == helpingHandOne[0]{
                    cards[helpingHandOne[0]].isHelpingHand = true
                } else if i == helpingHandOne[1]{
                    cards[helpingHandOne[1]].isHelpingHand = true
                } else if i == helpingHandOne[2]{
                    cards[helpingHandOne[2]].isHelpingHand = true
                }
            } else if helpingHandState == false {
                cards[i].isHelpingHand = false
            }
            refreshOnScreenCards()
        }
    }
    
    
    
    
    func isValidSet(card1: ViewModel.CardContent, card2: ViewModel.CardContent, card3: ViewModel.CardContent) -> Bool{
        //Color different
        let colorIsvalid = (card1.shapeColor == card2.shapeColor && card2.shapeColor == card3.shapeColor && card3.shapeColor == card1.shapeColor) ||
        (card1.shapeColor != card2.shapeColor && card2.shapeColor != card3.shapeColor && card1.shapeColor != card3.shapeColor)
        //Amount
        let amountIsvalid = (card1.shapeAmount == card2.shapeAmount && card2.shapeAmount == card3.shapeAmount && card1.shapeAmount == card3.shapeAmount) ||
        (card1.shapeAmount != card2.shapeAmount && card2.shapeAmount != card3.shapeAmount && card1.shapeAmount != card3.shapeAmount)
        //ShapeName
        let shapeNameIsvalid = (card1.shapeName == card2.shapeName && card2.shapeName == card3.shapeName && card1.shapeName == card3.shapeName) ||
        (card1.shapeName != card2.shapeName && card2.shapeName != card3.shapeName && card1.shapeName != card3.shapeName)
        //Opacity
        let opacityIsvalid = (card1.shapeOpacity == card2.shapeOpacity && card2.shapeOpacity == card3.shapeOpacity && card1.shapeOpacity == card3.shapeOpacity) ||
        (card1.shapeOpacity != card2.shapeOpacity && card2.shapeOpacity != card3.shapeOpacity && card1.shapeOpacity != card3.shapeOpacity)
        
        return colorIsvalid && amountIsvalid && shapeNameIsvalid && opacityIsvalid
    }
    
    //Function that shows (alt least on) solutions for the current Cards on Screen
    func helpingAdd(i: Int,j: Int,k: Int) -> [Int]{
        var oneSet: [Int] = []
        for n in 0..<numberOfCardsShown{
            if cards[i].id == cards[n].id{
                oneSet.append(n)
            }
            if cards[j].id == cards[n].id{
                oneSet.append(n)
            }
            if cards[k].id == cards[n].id{
                oneSet.append(n)
            }
        }
        return oneSet
    }
    
    
    func helpingHand() -> [[Int]] {
        var validSets: [[Int]] = []

        for i in 0..<numberOfCardsShown {
            for j in (i+1)..<numberOfCardsShown {
                for k in (j+1)..<numberOfCardsShown {
                    let checkingCard1 = cards[i]
                    let checkingCard2 = cards[j]
                    let checkingCard3 = cards[k]
                    if let card1 = checkingCard1.content as? ViewModel.CardContent, let card2 = checkingCard2.content as? ViewModel.CardContent, let card3 = checkingCard3.content as? ViewModel.CardContent{
                        if isValidSet(card1: card1, card2: card2, card3: card3) {
                            validSets.append(helpingAdd(i: i, j: j, k: k))
                                //validSets.append([cards[i].id, cards[j].id, cards[k].id])
                        }
                    }
                }
            }
        }
        return validSets
    }
    
    var helpingHandOne: [Int]{
        helpingHand()[0]
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
