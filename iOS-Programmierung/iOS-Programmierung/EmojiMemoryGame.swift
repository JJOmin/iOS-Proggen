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
    var themen = Themen<String>()
    
    @Published var scoreChange: Int? //Optional für Animation
    

    
    //static let emojis = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"]
    
    //initialisierungsmethode, zum erstellen eines 1. Games
    init() {
        let currentTheme = Theme<String>(theme: themen.themes.randomElement()!)
        let uniqueContentFromTheme = themen.returnCardsForGame(theme: currentTheme)
        
        model = MemoryGame(numberOfPairsOfCards: themen.returnCardsForGame(theme: currentTheme).count) {
            indexOfPair in uniqueContentFromTheme[indexOfPair]
        }
        currentThemeForModel = currentTheme
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
    func createNewMemoryGame() {
        let currentTheme = Theme<String>(theme: themen.themes.randomElement()!)
            let uniqueContent = themen.returnCardsForGame(theme: currentTheme)
            model = MemoryGame<String>(numberOfPairsOfCards: themen.returnCardsForGame(theme: currentTheme).count) { pairIndex in
                uniqueContent[pairIndex]
            }
            self.shuffle()
            currentThemeForModel = currentTheme
            
        }
    
    
    //Mischen Function
    func shuffle() {
        model.shuffle()
    }
    
    
    var score: Int {
            model.score
        }

    //MARK: -Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
        print("\(card)")
    }
    
    
   
    
    func getCardColor() -> Color{
        themen.getColor(colorString: currentThemeForModel.themeColor)
    }
    
    func getGroundColor() -> Color{
        themen.getColor(colorString: currentThemeForModel.backgroundColor)
    }
    
    func getThemeName()-> String{
        return currentThemeForModel.themeName
    }
    
    func getScore()-> Int{
        return model.getScore()
    }
    
    func getChangedScore()-> String{
        return model.getChangedScore()
    }
}
