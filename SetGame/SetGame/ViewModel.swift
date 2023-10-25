import SwiftUI

class ViewModel: ObservableObject {
    
    @Published private var model: Model<String>
    private var symbols: Symbols<String>
    @Published var cards: [Model<String>.Card] = [] // Initialize the cards array here
    
    init() {
        model = Model()
        symbols = Symbols() // Initialize symbols here if Symbols is a class or struct
        generateCards()
    }
    
    func getNumberOfCards() -> Int {
        return model.getNumberOfCards()
    }
    
    private func generateCards() {
        // Your card generation logic here using symbols
        for symbolName in symbols.getSymbolNames() {
            for color in symbols.getSymbolColors() {
                for opacity in symbols.getSymbolOpacitys() {
                    for amount in symbols.getSymbolAmounts() {
                        let card = Model<String>.Card(symbolName: symbolName as! String, primaryColor: symbols.getColor(colorString: color as! String), symbolOpacity: opacity as! Double, symbolAmount: amount as! Int, isMatched: false, id: cards.count)
                        cards.append(card)
                    }
                }
            }
        }
    }
}

