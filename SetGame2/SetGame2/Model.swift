import Foundation
import SwiftUI

// Model
struct Model<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var selectedCardIndices: Array<Int>
    private(set) var numberOfCardsInGame: Int
    private(set) var numberOfCardsShown: Int
    private(set) var score: Int
    private(set) var reactingString: String
    private(set) var numberOfPossiblePairs: Int
    
    var database = Database() //Zugriff auf die Database
    
    init(totalNumberOfCards: Int, numCardsShown: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        selectedCardIndices = []
        numberOfCardsInGame = totalNumberOfCards
        numberOfCardsShown = numCardsShown
        score = 0
        reactingString = " "
        numberOfPossiblePairs = 0
        
        
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
    
    
    mutating func choose (_ card: Card) {
        let chosenIndex = card.id - 1
        
        //Code for de/selecting cards
        if selectedCardIndices.count < 3 && cards[chosenIndex].isSelected == true{
            cards[chosenIndex].isSelected = false
            let helper = selectedCardIndices
            selectedCardIndices = helper.filter{$0 != chosenIndex}
        } else if selectedCardIndices.count < 3 && cards[chosenIndex].isSelected == false{
            cards[chosenIndex].isSelected = true
            selectedCardIndices.append(chosenIndex)
        }
        print(card.content)
        //Code for finding matches and removing Cards from cards array
        if selectedCardIndices.count == 3 {
            let selectedCard1 = cards[selectedCardIndices[0]]
            let selectedCard2 = cards[selectedCardIndices[1]]
            let selectedCard3 = cards[selectedCardIndices[2]]
                
            if let card1 = selectedCard1.content as? ViewModel.CardContent, let card2 = selectedCard2.content as? ViewModel.CardContent, let card3 = selectedCard3.content as? ViewModel.CardContent{
                
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
                
                if isValidSet(card1: card1, card2: card2, card3: card3){
                    //Remove from cards array
                    reactingString = "3 Selected & It's a Set"
                    
                    
                    
                } else {
                    reactingString = "3 Selected & thats not a Set"
                    
                }
                for i in 0..<selectedCardIndices.count{
                    cards[selectedCardIndices[i]].isSelected = false
                }
                selectedCardIndices = []
    
            }
        } else if selectedCardIndices.count == 2{
            reactingString = "2 Selected"
        } else if selectedCardIndices.count == 1{
            reactingString = "1 Selected"
        }
    }
}

