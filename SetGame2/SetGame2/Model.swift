import Foundation
import SwiftUI

// Model
struct Model<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var numberOfCardsInGame: Int
    var numberOfCardsShown: Int
    private(set) var score: Int
    private(set) var reactingString: String
    private(set) var numberOfPossiblePairs: Int
    private(set) var getPopupString: String
    var gridSize: CGFloat
    var scalingFactor: Double
    var startMatching = 0
    var deselecting: Int
    var placeholder: Int
    
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
            if cards[index].isMatched == true {
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
        reactingString = " "
        numberOfPossiblePairs = 0
        getPopupString = ""
        gridSize = 94
        scalingFactor = 1
        deselecting = 0
        placeholder = 0
        
        
        for i in 0..<totalNumberOfCards {
            let content: CardContent = createCardContent(i)
            let card = Card(id: i+1, content: content)
            cards.append(card)
        }
    }
    
    struct Card: Identifiable, Equatable {
        var id: Int
        var isSelected = false
        var isMatched = false
        var content: CardContent
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
        if card.isSelected == false && card.isMatched == false {
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = true
                //if deselecting ==
                deselecting += 1
                print(deselecting)
                //print("Selectet Cards: \(selectedCardIds)")
                print("Matched Cards:\(String(describing: matchedCardIds)) Selected Cards:\(selectedCardIds)")
            }
        } else if card.isSelected == true && card.isMatched == false{
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = false
                deselecting -= 1
                print(deselecting)
                print("Matched Cards:\(String(describing: matchedCardIds)) Selected Cards:\(selectedCardIds)")
            }
        }
        
        //Code to test if something sould be testet for match
        if selectedCardIds.count == 3{
            //print("Matching starts:\(selectedCardIds[0])\(selectedCardIds[1])\(selectedCardIds[2])")
            let selectedCard1 = cards[selectedCardIds[0]]
            let selectedCard2 = cards[selectedCardIds[1]]
            let selectedCard3 = cards[selectedCardIds[2]]
            
            if let card1 = selectedCard1.content as? ViewModel.CardContent, let card2 = selectedCard2.content as? ViewModel.CardContent, let card3 = selectedCard3.content as? ViewModel.CardContent{
                
                //wenn es ein set ist, dann setze matched status bei allen carten die matchen
                if isValidSet(card1: card1, card2: card2, card3: card3){
                    
                    if cards[selectedCardIds[0]].isMatched == false || cards[selectedCardIds[1]].isMatched == false || cards[selectedCardIds[2]].isMatched == false{
                        cards[selectedCardIds[0]].isMatched = true
                        cards[selectedCardIds[1]].isMatched = true
                        cards[selectedCardIds[2]].isMatched = true
                        score += 3
                        
                    }
                    
                } else {
                    //print(selectedCardIds[0]
                    print("Not a set")
                    //deselecting = 3
                }
            }
        }
        if deselecting == 4{
            //print("Gucken wir mal ob ich doch noch entfernen kann:\(matchedCardIds) \(selectedCardIds)")
            for i in cards.indices {
                if let fourthCardIndex = cards.firstIndex(where: { $0.id == card.id }){
                    if i != fourthCardIndex{
                        cards[i].isSelected = false
                    }
                }

            }
            for _ in 0..<3{
                for (index, element) in cards.enumerated() {
                    if element.isMatched == true {
                        cards.remove(at: index)
                    }
                }
            }
            //_ = matchedCardIds
            //_ = selectedCardIds
            print("Matched Cards:\(String(describing: matchedCardIds)) Selected Cards:\(selectedCardIds)")
            if selectedCardIds.count == 1 && matchedCardIds?.count == nil{
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
