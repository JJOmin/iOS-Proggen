//
//  Theme.swift
//  iOS-Programmierung
//
//  Created by Leonhard Tilly on 16.10.23.
// und Hilfestellung von Anna Rieckmann
//
import SwiftUI
import Foundation
class Themen<Cards>{
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
    
    
    //methode zum konvertieren von String Farben in Color Type
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
    // Methode, um eine zufällige Auswahl von Karten für das Spiel zurückzugebe
    func returnCardsForGame(theme: Theme<Cards>) -> [Cards] {
        let shuffledCards = theme.cardSet.shuffled() // Karten mischen
        var randomCardsForGame: Array<Cards> = [] // Array für die zufälligen Karten
        
        // Anzahl der ausgewählten Karten auf "numberOfPairs" begrenzen
        if theme.numberOfPairs <= theme.cardSet.count {
            for pairIndex in 0..<theme.numberOfPairs {
                randomCardsForGame.append(shuffledCards[pairIndex]) // Zufällige Karten auswählen
            }
        } else {
            randomCardsForGame = shuffledCards // Wenn mehr Karten benötigt werden als vorhanden sind, alle zurückgeben
        }
        
        return randomCardsForGame // Zufällige Karten zurückgeben
    }
    
    func getCardColor(theme: Theme<Cards>) -> Color{
        getColor(colorString: theme.themeColor)
    }
    
    func getGroundColor(theme: Theme<Cards>) -> Color{
        getColor(colorString: theme.backgroundColor)
    }
    
    func getThemeName(theme: Theme<Cards>)-> String{
        return theme.themeName
    }
}

// Definition der Struktur "Theme" mit generischem Typ "Cards"
struct Theme <Cards> {
    // Eigenschaften der Struktur
    
    let themeName: String // Der Name des Themas
    let cardSet: [Cards] // Ein Array von Kartensymbolen
    let themeColor: String // Die Hauptfarbe des Themas
    let backgroundColor: String // Die Hintergrundfarbe des Themas
    var numberOfPairs: Int // Die Anzahl der Kartensymbol-Paare im Spiel
    
    // Initialisierermethode, um ein Theme-Objekt von einem vorhandenen Theme zu erstellen
    init(theme: Theme<Cards>) {
        self.numberOfPairs = theme.numberOfPairs
        self.cardSet = theme.cardSet
        self.themeColor = theme.themeColor
        self.themeName = theme.themeName
        self.backgroundColor = theme.backgroundColor
    }
    
    // Initialisierermethode, um ein neues Theme-Objekt zu erstellen
    init(cardSet: [Cards], numberOfPairs: Int, themeColor: String, themeName: String, backgroundColor: String) {
        self.numberOfPairs = numberOfPairs
        self.cardSet = cardSet
        self.themeColor = themeColor
        self.themeName = themeName
        self.backgroundColor = backgroundColor
    }
    
}
