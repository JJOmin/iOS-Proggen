//
//  EmojiMemoryGame.swift
//  iOS-Programmierung
//  Created by Leonhard Tilly on 05.10.23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    //Variablen
    @Published private var model: MemoryGame<String>
    private var currentThemeForModel: Theme<String>
    static let emojis = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"]
    
    //initialisierungsmethode, zum erstellen eines 1. Games
    init() {
        let currentTheme = Theme<String>(theme: themes.randomElement()!)
        let uniqueContentFromTheme = currentTheme.returnCardsForGame()
        
        model = MemoryGame(numberOfPairsOfCards: currentTheme.returnCardsForGame().count) {
            indexOfPair in uniqueContentFromTheme[indexOfPair]
        }
        currentThemeForModel = currentTheme
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
    func createNewMemoryGame() {
            let currentTheme = Theme<String>(theme: themes.randomElement()!)
            let uniqueContent = currentTheme.returnCardsForGame()
            model = MemoryGame<String>(numberOfPairsOfCards: currentTheme.returnCardsForGame().count) { pairIndex in
                uniqueContent[pairIndex]
            }
            self.shuffle()
            currentThemeForModel = currentTheme
            
        }
    
    
    //Mischen Function
    func shuffle() {
        model.shuffle()
    }

    
    
    //MARK: -Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    private var themes = [
            Theme<String>(cardSet: ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"],
                          numberOfPairs: 16,
                          themeColor: "pink",
                          themeName: "Fruits",
                          groundColor: "green"),
            
            Theme<String>(cardSet: ["🐙","🪼","🦐","🦞","🦀","🐡","🐠","🐟","🐬","🐳","🐋","🦈","🦭"],
                          numberOfPairs: 13,
                          themeColor: "blue",
                          themeName: "Sea ​​Creatures",
                          groundColor: "indigo"),
    
            Theme<String>(cardSet: ["🌵","🎄","🌲","🌳","🌴","🪵","🌱","🌿","☘️","🍀","🎍","🪴","🎋","🍃","🍂","🍁","🍄","🌾","🪸"],
                          numberOfPairs: 19,
                          themeColor: "green",
                          themeName: "Plants",
                          groundColor: "mint"),
            
            Theme<String>(cardSet: ["⛷️","🏂","🪂","🏋️‍♀️","🤼‍♀️","🤸","🤺","🏌️","🏇","🧘‍♀️","🏄"],
                          numberOfPairs: 11,
                          themeColor: "yellow",
                          themeName: "Activeties",
                          groundColor: "gray"),
            
            Theme<String>(cardSet: ["🪇","🥁","🪘","🎷","🎺","🪗","🎸","🪕","🎻","🪈"],
                          numberOfPairs: 5,
                          themeColor: "orange",
                          themeName: "Instruments",
                          groundColor: "black"),
            
            Theme<String>(cardSet: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜"],
                          numberOfPairs: 14,
                          themeColor: "gray",
                          themeName: "Cars",
                          groundColor: "white"),]
    
    
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
    
    //Methoden fr die Farben
    func getCardColor() -> Color{
        getColor(colorString: currentThemeForModel.themeColor)
    }
    
    func getGroundColor() -> Color{
        getColor(colorString: currentThemeForModel.groundColor)
    }
    
    func getThemeName()-> String{
        return currentThemeForModel.themeName
    }
    
    func getScore()-> Int{
        return model.getScore()
    }
}
