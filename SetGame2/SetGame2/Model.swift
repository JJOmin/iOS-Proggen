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
        var selectedCardIndecies = [Int]()
        for index in cards.indices{
            if cards[index].isSelected == true{
                selectedCardIndecies.append(index)
            }
        }
        
        if selectedCardIndecies.count == 1{
            return [selectedCardIndecies[0]]
        } else if selectedCardIndecies.count == 2{
            var cardArray = [Int]()
            cardArray.append(selectedCardIndecies[0])
            cardArray.append(selectedCardIndecies[1])
            return cardArray //cardArray
        } else if selectedCardIndecies.count == 3{
            var cardArray = [Int]()
            cardArray.append(selectedCardIndecies[0])
            cardArray.append(selectedCardIndecies[1])
            cardArray.append(selectedCardIndecies[2])
            return cardArray //cardArray
        } else {
            let cardArray = [Int]()
            //print("Achtung zu viel ausgewählt")
            return cardArray
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
        if card.isSelected == false {
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = true
                //if deselecting ==
                deselecting += 1
                //print("Selectet Cards: \(selectedCardIds)")
                print("Matched Cards:\(String(describing: matchedCardIds)) Selected Cards:\(selectedCardIds)")
            }
        } else if card.isSelected == true {
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = false
                deselecting -= 1
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
                    print("SET")
                    
                    cards[selectedCardIds[0]].isMatched = true
                    cards[selectedCardIds[1]].isMatched = true
                    cards[selectedCardIds[2]].isMatched = true
                    score += 3
                    //deselecting = 3
                    
                    

                    
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
            _ = matchedCardIds
            _ = selectedCardIds
            print("Matched Cards:\(String(describing: matchedCardIds)) Selected Cards:\(selectedCardIds)")
            if selectedCardIds.count == 1 && matchedCardIds?.count == nil{
                //deselecting = 0
            }
            
        }
        
        //print(selectedCardIds)
        //let chosenIndex = card.id - 1
        /*
        //Code for de/selecting cards
        if selectedCardIds.count <= 3 && card.isSelected == true && placeholder == 0{
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = false
                let helper = selectedCardIds
                selectedCardIds = helper.filter{$0 != card.id}
            }; startMatching -= 1
            
            
        } else if selectedCardIds.count < 3 && card.isSelected == false && placeholder == 0{
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards[index].isSelected = true
                selectedCardIds.append(card.id)
                //print(cards[index])
                //print(selectedCardIds)
                
            }; startMatching += 1
            
        } else if selectedCardIds.count == 3 || placeholder == 1 {
            
                if matched == false {
                    //print("Hello")
                    placeholder = 1
                    
                    //entfernt den selected status der nicht gematchten Karten
                    for index in 0..<selectedCardIds.count{
                        if let cardsIndex = cards.firstIndex(where: { $0.id == selectedCardIds[index] }){
                            cards[cardsIndex].isSelected = false
                        }
                    }
                    
                    //Removing all indexes from selectedCardIds Array
                    for i in 0...2 {
                        //print(selectedCardIds,i,selectedCardIds[0])
                        selectedCardIds.removeFirst()
                    }
                    //print(selectedCardIds,selectedCardIds[0])
                    
                    
                    //Hinzufügen neuer Karte
                    selectedCardIds.append(card.id)
                    if let index = cards.firstIndex(where: { $0.id == card.id }) {
                        cards[index].isSelected = true
                    }
                    
                    
                    
                    //Append neues
                    
                    //print(selectedCardIds)
                    
                        /*
                        if let index = selectedCardIds.firstIndex(of: selectedCardIds[i]) {
                            selectedCardIds.remove(at: index)
                        }*/
                        //selectedCardIds = helper.filter{$0 != cardIdToRemove}
                        //print(selectedCardIds[i])
                        
                        
                        /*
                        if let index = cards.firstIndex(where: { $0.id == cardIdToRemove }) {
                            print(selectedCardIds[i], index)
                            
                            
                            
                            
                            //cards[index].isSelected = false
                            
                            if let n = selectedCardIds.firstIndex(of: cardIdToRemove) {
                                selectedCardIds.remove(at: n)
                            }
                        }*/
                    
                                   
            
            } else {
                print("Hier bin ich lol")
                print(selectedCardIds)
                print(cards[selectedCardIds[0]])
                print(cards[selectedCardIds[1]])
                print(cards[selectedCardIds[2]])
                /*
                cards.removeAll { $0.id == selectedCardIndices[0] }
                cards.removeAll { $0.id == selectedCardIndices[1] }
                cards.removeAll { $0.id == selectedCardIndices[2] }
                numberOfCardsInGame -= 3
                selectedCardIndices = []
                 */
                
            }
        }
        if startMatching == 3 {
            findingMatches()
        }
         */
    }/*
    
    
    mutating func findingMatches(){
        
        
        
        //DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
        let selectedCard1 = cards[selectedCardIds[0]]
        let selectedCard2 = cards[selectedCardIds[1]]
        let selectedCard3 = cards[selectedCardIds[2]]
        
        if let card1 = selectedCard1.content as? ViewModel.CardContent, let card2 = selectedCard2.content as? ViewModel.CardContent, let card3 = selectedCard3.content as? ViewModel.CardContent{
            
            
            if isValidSet(card1: card1, card2: card2, card3: card3){
                for i in 0..<3{
                    cards[selectedCardIds[i]].isMatched = true
                    cards[selectedCardIds[i]].isSelected = false
                }
                startMatching = 0
                matched = true
                print("Matched")
                
                
                //Remove from cards array
                //Falls weniger Karten existieren als angezeigt werden sollen
                /*
                if numberOfCardsShown > cards.count-3 {
                    numberOfCardsShown -= 3
                }
                
                score += 1
                
                for i in 0..<selectedCardIndices.count{
                    cards[selectedCardIndices[i]].isSelected = false
                }
                
                //Remove the three cards from Cards:
                cards.removeAll { $0.id == selectedCardIndices[0] }
                cards.removeAll { $0.id == selectedCardIndices[1] }
                cards.removeAll { $0.id == selectedCardIndices[2] }
                numberOfCardsInGame -= 3
                selectedCardIndices = []
                 */
                
                
            } else {
                matched = false
                startMatching = 0
                print("not matched")
                print(selectedCardIds)
                /*
                for i in 0..<3{
                    cards[selectedCardIndices[i]].isSelected = false
                };selectedCardIndices = []*/
                
            }
        }
    }
    
      */
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


