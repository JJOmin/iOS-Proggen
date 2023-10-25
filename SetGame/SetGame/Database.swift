//
//  Database.swift
//  SetGame
//
//  Created by Leonhard Tilly on 25.10.23.
//A place to store all valuable information

import Foundation
import SwiftUI

internal struct Database{
    
    func getColor(colorString : String) -> Color {
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
        return colorMapping[colorString] ?? .red
    }
    
    var shapes = ["Pill", "Rectangle", "Diamond"]
    var colors = ["green", "blue", "pink"]
    var opacitys = [0.0, 0.5, 1.0]
    var amounts = [1,2,3]
    
    var startingNumberOfCards = 12
    var totalNumberOfCards = 81
    
    func getShapeNames() -> Array<String>{
        return shapes
    }
    
    func getShapeColors() -> Array<String>{
        return colors
    }
    
    func getShapeOpacitys() -> Array<Double>{
        return opacitys
    }
    func getShapeAmounts() -> Array<Int>{
        return amounts
    }
    
    func getTotalNumberOfCards() -> Int{
        return totalNumberOfCards
    }
    
    func getStartingNumberOfCards() -> Int{
        return startingNumberOfCards
    }
    
    
}
