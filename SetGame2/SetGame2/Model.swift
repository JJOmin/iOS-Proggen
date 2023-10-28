import Foundation

// Model
struct Model<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var selectedCardIndices: Array<Int>
    private(set) var numberOfCardsInGame: Int
    private(set) var numberOfCardsShown: Int
    private(set) var score: Int
    private(set) var reactingString: String
    
    var database = Database() //Zugriff auf die Database
    
    init(totalNumberOfCards: Int, numCardsShown: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        selectedCardIndices = []
        numberOfCardsInGame = totalNumberOfCards
        numberOfCardsShown = numCardsShown
        score = 0
        reactingString = " "
        
        
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
        
        //Code for finding matches and removing Cards from cards array
        if selectedCardIndices.count == 3 {
            //reactingString = "Vergleiche"
            
            
            /*
              //1. Fall: Color:same & Opacity: same & Shape: same but amount: different
              2. Fall: Color:same & Opacity: same & Shape: differen but            amount: same
              3. Fall: Color:same & Opacity: different & Shape: same but           amount: same
              4. Fall: Color: different & Opacity: same & Shape: same but          amount: same
              5. Fall: Color: different & Opacity: different & Shape:              different & amount: different
              Else not matched */
            //if cards[selectedCardIndices[0]].content
            
            //print(cards[1].content.shapeName)
                //cards[i].isSelected = false
            
        }
        
        
        
        
        //if cards[chosenIndex-1].isSelected
        //print(cards[chosenIndex-1].isSelected)
        //card.isSelected.toggle()
        //print(card.id-1)
        
        //Update der numberOfCardsInGame basierend auf den matches im game
        //numberOfCardsInGame = cards.cound
        //print(cards.count)
        
        /*
        Logic to Compare Three Cards:
            -Only compare if 3 Cards Selected //if there are three         Values in var selectedCardsIndicies
                -Only Compare Cards.Content
        */
    }
}
