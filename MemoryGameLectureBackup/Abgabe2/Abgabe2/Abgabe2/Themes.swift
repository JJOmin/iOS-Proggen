//
//  Themes.swift
//  Abgabe2
//
//  Created by Leonhard Tilly on 22.10.23.
//

import Foundation
import SwiftUI

struct Theme <Cards> {
    
    //lets
    let name: String //Name des Themes
    let setOfCards: [Cards] //Mögliche Karten des Themes in einem Array
    let primaryColor: String //Hintergrundfarbe als Strings
    let secondaryColor: String //""
    let backgroundColour: String //""
    
    //Variable(s)
    var numberOfPairs: Int //holds the number of Pairs of the Theme
    
    
    //Initalizer for "external" access to get all infos
    init(name: String, setOfCards: [Cards], primaryColor: String, secondaryColor: String, backgroundColour: String, numberOfPairs: Int){
        self.numberOfPairs = numberOfPairs
        self.backgroundColour = backgroundColour
        self.secondaryColor = secondaryColor
        self.primaryColor = primaryColor
        self.setOfCards = setOfCards
        self.name = name
    }
    
    //initializer for the Themes itself
    init(theme: Theme<Cards>){
        self.numberOfPairs = theme.numberOfPairs
        self.backgroundColour = theme.backgroundColour
        self.secondaryColor = theme.secondaryColor
        self.primaryColor = theme.primaryColor
        self.setOfCards = theme.setOfCards
        self.name = theme.name
    }
}

//Class that holds all possible themes, its values and funcs to get, set ...
class Themes<Cards>{
    
    
    //anpassung notwendig!!!
    var themes = [
            Theme<String>(cardSet: ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"],
                          numberOfPairs: 16, //16
                          themeColor: "pink",
                          themeName: "Fruits",
                          backgroundColor: "green"),
            
            Theme<String>(cardSet: ["🐙","🪼","🦐","🦞","🦀","🐡","🐠","🐟","🐬","🐳","🐋","🦈","🦭"],
                          numberOfPairs: 13, //13
                          themeColor: "blue",
                          themeName: "Sea ​​Creatures",
                          backgroundColor: "indigo"),
            
            Theme<String>(cardSet: ["🌵","🎄","🌲","🌳","🌴","🪵","🌱","🌿","☘️","🍀","🎍","🪴","🎋","🍃","🍂","🍁","🍄","🌾","🪸"],
                          numberOfPairs: 19, //19
                          themeColor: "green",
                          themeName: "Plants",
                          backgroundColor: "mint"),
            
            Theme<String>(cardSet: ["⛷️","🏂","🪂","🏋️‍♀️","🤼‍♀️","🤸","🤺","🏌️","🏇","🧘‍♀️","🏄"],
                          numberOfPairs: 11, //11
                          themeColor: "yellow",
                          themeName: "Activeties",
                          backgroundColor: "gray"),
            
            Theme<String>(cardSet: ["🪇","🥁","🪘","🎷","🎺","🪗","🎸","🪕","🎻","🪈"],
                          numberOfPairs: 5,
                          themeColor: "orange",
                          themeName: "Instruments",
                          backgroundColor: "black"),
            
            Theme<String>(cardSet: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜"],
                          numberOfPairs: 14, //14
                          themeColor: "gray",
                          themeName: "Cars",
                          backgroundColor: "white"),]
    
}
