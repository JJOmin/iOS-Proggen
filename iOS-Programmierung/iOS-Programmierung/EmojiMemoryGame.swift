//
//  EmojiMemoryGame.swift
//  iOS-Programmierung
//Stehen geblieben bei annas code zur aaufgabe (shuffle)
//  Created by Leonhard Tilly on 05.10.23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    //Variablen
    @Published private var model: MemoryGame<String> = createMemoryGame()
    private var currentThemeForModel: Theme<String>
    static let emojis = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"]
    
    
    //methoden
    
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
            self.shuffle()  // mischen working on
            currentThemeForModel = currentTheme
            
        }
    //Mischen Function
    func shuffle() {
        model.shuffle()
    }


    
    
    static func createMemoryGame() ->MemoryGame<String>{
            return MemoryGame<String>(numberOfPairsOfCards: 16) {pairIndex in
                emojis[pairIndex]
        }
    
    }
    
    
    //MARK: -Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    private var themes = [
            Theme<String>(cardSet: ["🧛🏼‍♀️","☠️","🧟‍♂️","⚰️","🔮","👻","🎃","👽","🦹‍♀️","🦇","🌘","🕷"],
                          numberOfPairs: 12,
                          themeColor: "orange",
                          themeName: "Halloween",
                          groundColor: "black"),
            
            Theme<String>(cardSet: ["🍉","🍐","🍓","🍊","🍋","🍌","🥭","🍒","🍈","🫐","🍇","🍏"],
                          numberOfPairs: 6,
                          themeColor: "red",
                          themeName: "Obst",
                          groundColor: "green")]
}
