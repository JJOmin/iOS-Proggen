//
//  ViewModel.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 27.10.23.
//

//ViewModel
import SwiftUI
class ViewModel: ObservableObject{
    
    //-----------------Statics as Initalizer:-----------------
    static func createSetGame() -> Model<ViewModel.CardContent> {
        Model<ViewModel.CardContent>(totalNumberOfCards: totalNumberOfCards) { index in
            let properties = shapePropertyArray.shuffled()[index]
            return CardContent(shapeName: properties[0] as! String,
                               shapeColor: properties[1] as! Color,
                               shapeAmount: properties[2] as! Int,
                               shapeOpacity: properties[3] as! Double)
        }
    }
    struct CardContent: Equatable {
        let shapeName: String
        let shapeColor: Color
        let shapeAmount: Int
        let shapeOpacity: Double
    }
    
    static var shapePropertyArray: [[Any]] = fillArrays()

    static func fillArrays() -> [[Any]] {
            var cardInstance: [[Any]] = []
            for name in shapeNames {
                for color in shapeColors {
                    for amount in shapeAmounts {
                        for opacity in shapeOpacitys {
                            cardInstance.append([name, getColor(colorString: color), amount, opacity] as [Any])
                        }
                    }
                }
            };
        //cardInstance.shuffle()
        return cardInstance
    }
    
    
    static func getColor(colorString : String) -> Color {
        let colorMapping: [String: Color] = [
            "white": .white,
            "red": .red,
            "orange": .orange,
            "blue": .blue,
            "green": .green,
            "gray": .gray,
            "purple": .purple,
            "pink": .pink,
            "yellow": .yellow,
            "black": .black,
            "indigo": .indigo,
            "mint": .mint
        ]
        //wenn farbe vorhanden, dann return als Color Type ansonsten red
        return colorMapping[colorString] ?? .black
    }
    
    
    //-----------------Used on every Instance:-----------------
    @Published private var model: Model<CardContent> = createSetGame()
    
    var cards: Array<Model<CardContent>.Card>{
        return model.cards
    }
    
    var onScreenCards: Array<Model<CardContent>.Card>{
        return model.onScreenCards
    }

    var numberOfCardsShown: Int {
        return model.numberOfCardsShown
    }
    
    var getScore: Int {
        return model.score
    }
    
    var getPopupString: String{
        model.getPopupString
    }
    
    var possibleMatches: Int{
        model.helpingHand().count
    }
    
    var helpingHandState: Bool{
        model.helpingHandState
    }
    
    var isAddCardsButtonActive: Bool{
        model.isAddCardsButtonActive
    }
    
    var matchedCards: Array<Model<ViewModel.CardContent>.Card>{
        return model.matchedCards
    }
    
    
    
    
    
    //Funktionen
    func createNewSetGame() {
        ViewModel.shapePropertyArray.shuffle() // Karten mischen, bevor sie dem Spiel hinzugefügt werden
        model = ViewModel.createSetGame()
    }
    
    func replaceMatchedCards(){
        model.replaceCardsButton()
    }
    
    
    func helpingHandToggle(){
        model.toggleHelpingHand()
    }
    
    
    func addThreeCards(){
        //model.addCardsOnScreen()
    }
    
    
    
    
    //-----------------MARK: - Intent(s):-----------------
    func choose(_ card: Model<CardContent>.Card){
        model.choose(card)
    }

    
    static var shapeNames: [String]  = ["Pill", "Diamond", "Rectangle"]
    static var shapeColors: [String]  = ["blue", "yellow", "black"]
    static var shapeOpacitys: [Double] = [0, 0.3, 1]
    static var shapeAmounts: [Int] = [1,2,3]
    static var totalNumberOfCards: Int = 81
}


