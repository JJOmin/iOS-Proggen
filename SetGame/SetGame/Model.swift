//MODEL
//  Model.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//

import Foundation
import SwiftUI
struct Model<CardShapeName, CardShapeColor, CardShapeOpacity, CardShapeAmount> //where CardShapeName: type , CardShapeColor: Array<Any>, CardShapeOpacity: Array<Any>
{
    
    //Var
    var cards: Array<Card>
    private(set) var startingNumberOfCards: Int
    private(set) var totalNumberOfCards: Int
    private let createCardSymbol: (Int) -> Card.CardContent
    private(set) var arrayOfPlayingCards: [Card]
    
    var score = 0
    var id = 0
    private(set) var numberOfMatchedCards = 0
    
    //indexofonandonly später
    
    
    //private(set) var numberOfCards: Int //var for the numberOfCards
    
    //private(set)
    init(startingNumberOfCards: Int, totalNumberOfCards: Int, createCardContent: @escaping (Int) -> Card.CardContent){
        self.startingNumberOfCards = startingNumberOfCards //Number of cards to show after Creating a new Game
        self.totalNumberOfCards = totalNumberOfCards
        self.createCardSymbol = createCardContent
        self.arrayOfPlayingCards = []
        self.cards = []
        self.id = 0
    }
    
    func init2(){
        print("Test")
    }
    
    /*
    func getShapeNames() -> Array<String>{
        return database.shapes
    }
    
    func getShapeColors() -> Array<String>{
        return database.colors
    }
    
    func getShapeOpacitys() -> Array<Double>{
        return database.opacitys
    }
    
    func getShapeAmounts() -> Array<Int>{
        return database.amounts
    }
    
    func getStartingNumberOfCards() -> Int {
        return database.startingNumberOfCards
    }
     */
    
    /*
    mutating func generateCardContent() {
        //print(database.getShapeNames())
        for shapeName in database.getShapeNames(){
            for shapeColor in database.getShapeColors(){
                for shapeOpacity in database.getShapeOpacitys(){
                    for shapeAmount in database.amounts{
                        id += 1
                        cards.append(Model<shapeName, shapeColor, shapeOpacity, shapeAmount>.Card)
                        //print("ShapeName: \(shapeName), Color: \(shapeColor),Opacity: \(shapeOpacity), Amount: \(shapeAmount),ID: \(id)")
                    }
                }
                
            }
        }
     
        
            

    }*/
    

    
    struct Card: Identifiable, Equatable {
        //Outside Name "Model.Card"
        //var symbolName: String //Form
        //var primaryColor: Color //Farbe
        //var symbolOpacity: Double //Füllung (nichts, schraffiert, komplett)
        //var symbolAmount: Int //Anzahl der Objekte
        var content: CardContent
        var isMatched: Bool = false//Var die beinhaltet ob matched oder nicht
        var isSelected: Bool = false
        var id: Int //zuordnung

        struct CardContent{
            let shape: CardShapeName
            let color: CardShapeColor
            let opacity: CardShapeOpacity
            let amountOfShapes: CardShapeAmount
        }
        static func == (lhs: Model<CardShapeName, CardShapeColor, CardShapeOpacity, CardShapeAmount>.Card, rhs: Model<CardShapeName, CardShapeColor, CardShapeOpacity, CardShapeAmount>.Card) -> Bool {
                    lhs.id == rhs.id
                }
    }
    
    
    //neuerungen

    mutating func createNewGame() {
        self.score = 0
        self.arrayOfPlayingCards = []
        self.cards = []
        self.numberOfMatchedCards = 0
        for x in 0..<self.totalNumberOfCards{
            let content = createCardSymbol(x) //erstellt Card Symbol
            let newCard = Card(content: content, id: x) //erstellt neue Card mit id und Inhalt
            self.cards.append(newCard)
        }
        self.cards.shuffle()
        
        for x in stride(from: startingNumberOfCards-1 , through: 0, by: -1)  {
                    
            self.arrayOfPlayingCards.append(self.cards[x])
            self.cards.remove(at: x)
            self.numberOfMatchedCards += 1
            //print("Model,createNewGame so richtig?,\(self.numberOfMatchedCards)")
                
        }
        
    }
 
    
    //mutating func threeNewCards(){ erweiterung später
    //func choose zur abfrage später
        
    
}
    


