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
    //Themes Data
    var themes = [
            Theme<String>(name: "Fruits",
                          setOfCards: ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"],
                          primaryColor: "pink",
                          secondaryColor: "green",
                          backgroundColour: "gray",
                          numberOfPairs: 16), //16
            
            Theme<String>(name: "Sea Creatures",
                          setOfCards: ["🐙","🪼","🦐","🦞","🦀","🐡","🐠","🐟","🐬","🐳","🐋","🦈","🦭"],
                          primaryColor: "blue",
                          secondaryColor: "indigo",
                          backgroundColour: "gray",
                          numberOfPairs: 13), //13
            
            Theme<String>(name: "Plants",
                          setOfCards: ["🌵","🎄","🌲","🌳","🌴","🪵","🌱","🌿","☘️","🍀","🎍","🪴","🎋","🍃","🍂","🍁","🍄","🌾","🪸"],
                          primaryColor: "green",
                          secondaryColor: "mint",
                          backgroundColour: "gray",
                          numberOfPairs: 18), //19
            
            Theme<String>(name: "Activeties",
                          setOfCards: ["⛷️","🏂","🪂","🏋️‍♀️","🤼‍♀️","🤸","🤺","🏌️","🏇","🧘‍♀️","🏄"],
                          primaryColor: "yellow",
                          secondaryColor: "gray",
                          backgroundColour: "gray",
                          numberOfPairs: 11), //11
            
            Theme<String>(name: "Instruments",
                          setOfCards: ["🪇","🥁","🪘","🎷","🎺","🪗","🎸","🪕","🎻","🪈"],
                          primaryColor: "orange",
                          secondaryColor: "black",
                          backgroundColour: "gray",
                          numberOfPairs: 5), //5
            
            Theme<String>(name: "Cars",
                          setOfCards: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜"],
                          primaryColor: "gray",
                          secondaryColor: "white",
                          backgroundColour: "gray",
                          numberOfPairs: 14),] //14
    
    func returnCards(theme: Theme<Cards>) ->[Cards]{ //should return the cards
        let shuffeldCards = theme.setOfCards.shuffled() //build in func to shuffle
        var shuffeldCardArray: Array<Cards> = [] //definierung einer var
        
        if theme.numberOfPairs <= theme.setOfCards.count{ //solange anzahl der Pairs <= anzahl der elemente im array ist
            for pairIndex in 0..<theme.numberOfPairs{ //für alle elemente in number of Pairs
                shuffeldCardArray.append(shuffeldCardArray[pairIndex]) //füge dem Array shuffeld Cards hinzu (bis es genau so viele sind wie anzahl an Pairs)
            }
            
        }else{
            shuffeldCardArray = shuffeldCards //das Ganze Array, wenn numberOfPairs voll
        }
        return shuffeldCardArray
    }
    
    
    func convertStringToColor(_ colorString: String) -> Color{
        switch colorString {
        case "red":
            return .red
        case "white":
            return .white
        case "green":
            return .green
        case "orange":
            return .orange
        case "blue":
            return .blue
        case "mint":
            return .mint
        case "indigo":
            return .indigo
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "yellow":
            return .yellow
        case "black":
            return .black
        case "gray":
            return .gray
            
        default:
            return .teal
        }
    }
    
    func getPrimaryColor(theme: Theme<Cards>) -> Color{
        return convertStringToColor(theme.primaryColor) //converts Color String to color Value and returns it
    }
    
    func getSecondaryColor(theme: Theme<Cards>) -> Color{
        return convertStringToColor(theme.secondaryColor) //converts Color String to color Value and returns it
    }
    
    func getThemeName(theme: Theme<Cards>) -> String{
        return theme.name //converts the Theme name
    }
}
