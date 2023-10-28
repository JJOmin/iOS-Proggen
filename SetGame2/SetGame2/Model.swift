import Foundation

// Model
struct Model<CardContent> where CardContent: Hashable {
    private(set) var cards: Array<Card>
    var selectedCardIndices: Array<Int>
    private(set) var numberOfCardsInGame: Int
    private(set) var numberOfCardsShown: Int
    
    init(totalNumberOfCards: Int, numCardsShown: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        selectedCardIndices = []
        numberOfCardsInGame = totalNumberOfCards
        numberOfCardsShown = numCardsShown
        
        
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
    
    
    
    
    func choose (_ card: Card) {
        //Update der numberOfCardsInGame basierend auf den matches im game
        //numberOfCardsInGame = cards.cound
        //print(cards.count)
        /*
        1. Fall: Color:same & Opacity: same & Shape: same but amount: different
        2. Fall: Color:same & Opacity: same & Shape: differen but            amount: same
        3. Fall: Color:same & Opacity: different & Shape: same but           amount: same
        4. Fall: Color: different & Opacity: same & Shape: same but          amount: same
        5. Fall: Color: different & Opacity: different & Shape:              different & amount: different
        Else not matched
        
        Logic to Compare Three Cards:
            -Only compare if 3 Cards Selected //if there are three         Values in var selectedCardsIndicies
                -Only Compare Cards.Content
        */
    }
}
