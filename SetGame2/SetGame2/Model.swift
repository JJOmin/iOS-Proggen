import Foundation
import SwiftUI

// Model
struct Model<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var selectedCardIndices: Array<Int>
    private(set) var numberOfCardsInGame: Int
    var numberOfCardsShown: Int
    private(set) var score: Int
    private(set) var reactingString: String
    private(set) var numberOfPossiblePairs: Int
    private(set) var getPopupString: String
    var gridSize: CGFloat
    var scalingFactor: Double
    var startMatching = 0
    var matched: Bool
    
    var database = Database() //Zugriff auf die Database
    
    init(totalNumberOfCards: Int, numCardsShown: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        selectedCardIndices = []
        numberOfCardsInGame = totalNumberOfCards
        numberOfCardsShown = numCardsShown
        score = 0
        reactingString = " "
        numberOfPossiblePairs = 0
        getPopupString = ""
        gridSize = 94
        scalingFactor = 1
        matched = false
        
        
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
        if numberOfCardsShown <= 78{
            numberOfCardsShown += 3
        } else {
            getPopupString = "All Cards are Shown"
        }
    }
    
    
    
    
    mutating func choose (_ card: Card) {
        //let chosenIndex = card.id - 1
        
        //Code for de/selecting cards
        if selectedCardIndices.count <= 3 && card.isSelected == true {
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = false
                let helper = selectedCardIndices
                selectedCardIndices = helper.filter{$0 != index}
            }
            
            startMatching -= 1
            print(startMatching)
            
        } else if selectedCardIndices.count < 3 && card.isSelected == false{
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = true
                selectedCardIndices.append(index)
            }
            startMatching += 1
            print(startMatching)
            
        } else if selectedCardIndices.count == 3 {
            
            for i in selectedCardIndices {
                if let index = cards.firstIndex(where: { $0.id == i }) {
                    cards[index].isSelected = false
                    
                }
            }
            print(selectedCardIndices)
            //findingMatches
            
            /*
            
            
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = true
                selectedCardIndices.append(index)
            }
            */
        }
        //print(card.content)
        //Code for finding matches and removing Cards from cards array
    }
    
    
    mutating func findingMatches() -> Bool{
        
        
        //DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
        let selectedCard1 = cards[selectedCardIndices[0]]
        let selectedCard2 = cards[selectedCardIndices[1]]
        let selectedCard3 = cards[selectedCardIndices[2]]
        
        if let card1 = selectedCard1.content as? ViewModel.CardContent, let card2 = selectedCard2.content as? ViewModel.CardContent, let card3 = selectedCard3.content as? ViewModel.CardContent{
            
            
            if isValidSet(card1: card1, card2: card2, card3: card3){
                
                //Remove from cards array
                getPopupString = "3 Selected & It's a Set"
                score += 1
                
                for i in 0..<selectedCardIndices.count{
                    cards[selectedCardIndices[i]].isSelected = false
                }
                
                //Remove the three cards from Cards:
                cards.removeAll { $0.id == selectedCardIndices[0] }
                cards.removeAll { $0.id == selectedCardIndices[1] }
                cards.removeAll { $0.id == selectedCardIndices[2] }
                selectedCardIndices = []
                matched = true
                
            } else {
                reactingString = "3 Selected & thats not a Set"
                for i in 0..<selectedCardIndices.count{
                    cards[selectedCardIndices[i]].isSelected = false
                };selectedCardIndices = []
                matched = false
            }
        }; startMatching = 0
        return matched
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

