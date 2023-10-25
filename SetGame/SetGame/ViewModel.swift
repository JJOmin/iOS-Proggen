import SwiftUI

class ViewModel: ObservableObject {
    
    //Properties
    @Published var model: Model<String, String, Double, Int>
    //private var symbols: Symbols<String>
    //@Published var cards: [Model<String, String, Double, Int>.Card] = [] // Initialize the cards array here
    typealias Card = Model<String, String, Double, Int>.Card
    @Published var cards: [Model<String, String, Double, Int>.Card] = []
    var database = Database() //Zugriff auf die Database
    var id = 0
    
    
    init(){
        model = Model(startingNumberOfCards: database.startingNumberOfCards, totalNumberOfCards: database.totalNumberOfCards, createCardContent: generateCardContent())
        
        
        getCardContent()
    }
    
    
    func generateCardContent() -> [Model<String, String, Double, Int>.Card] {
        for shapeName in database.shapes{
                for shapeColor in database.colors{
                    for shapeOpacity in database.opacitys{
                        for shapeAmount in database.amounts{
                            id += 1
                            let cardContent = Card.CardContent(shape: shapeName, color: shapeColor, opacity: shapeOpacity, amountOfShapes: shapeAmount)
                            let card = Card(content: cardContent, id: id)
                            cards.append(card) // Füge die Karte zum cards-Array hinzu
                            
                        }
                    }
                }
        };return cards//; print("\(model.id)")
        }
    
    func getCardContent(){
        print(model.arrayOfPlayingCards)
    }
        /*
         init() {
         model = Model(startingNumberOfCards: 5, totalNumberOfCards: 81, createCardContent: { _ in Card.CardContent(shape: "", color: "", opacity: 0.0, amountOfShapes: 0) })
         symbols = Symbols()
         model.generateUniqueCards()
         cards = model.cards
         }
         
         
         
         private func generateCards() {
         // Your card generation logic here using symbols
         let card = Model<<#CardShapeName: Hashable#>, <#CardShapeColor: Hashable#>, <#CardShapeOpacity: Hashable#>, Any>(startingNumberOfCards: symbols.getStartingNumberOfCards(), totalNumberOfCards: symbols.getTotalNumberOfCards(), createCardContent: symbols.generateCardContents())
         cards.append(card)
         }*/
        
        
        
        
    func getCards() -> [Model<String, String, Double, Int>.Card]{
        return model.cards
    }
}
