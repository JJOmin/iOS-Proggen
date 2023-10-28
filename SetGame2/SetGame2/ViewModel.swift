//
//  ViewModel.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 27.10.23.
//

//ViewModel
import SwiftUI


class ViewModel{
    
    //-----------------Statics as Initalizer:-----------------
    static func createSetGame() -> Model<ViewModel.CardContent> {
        Model<ViewModel.CardContent>(totalNumberOfCards: 81, numCardsShown: 12) { index in
            let properties = shapePropertyArray[index]
            return CardContent(shapeName: properties[0] as! String,
                               shapeColor: properties[1] as! String,
                               shapeAmount: properties[2] as! Int,
                               shapeOpacity: properties[3] as! Double)
        }
    }
    
    struct CardContent: Hashable {
        let shapeName: String
        let shapeColor: String
        let shapeAmount: Int
        let shapeOpacity: Double
    }
    
    //Setting the array into a let
    static let shapePropertyArray: [[Any]] = fillArrays()

    //Function to create a Array of Propertys for the Shapes as CardContent
        //Eventuelle auslagerung der Basispropertys
    static func fillArrays() -> [[Any]] {
            var cardInstance: [[Any]] = []
            for name in ["Pill", "Diamond", "Rectangle"] {
                for color in ["blue", "green", "pink"] {
                    for amount in [1, 2, 3] {
                        for opacity in [0.0, 0.5, 1.0] {
                            cardInstance.append([name, color, amount, opacity] as [Any])
                        }
                    }
                }
            };return cardInstance
    }
    //--------------------------------------------------------
    
    
    //-----------------Used on every Instance:-----------------
    private var model: Model<CardContent> = createSetGame()
    
    var cards: Array<Model<CardContent>.Card>{
        return model.cards
    }

    var numberOfCardsShown: Int {
        return model.numberOfCardsShown
    }
    //On ICe
    /*
    var numberOfCardsInGame: Int {
        return model.numberOfCardsInGame
    }
    */
    //--------------------------------------------------------
}


