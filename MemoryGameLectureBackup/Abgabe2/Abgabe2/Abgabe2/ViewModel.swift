//
//  ViewModel.swift
//  MemoryGameLecture
//
//  Created by Leonhard Tilly on 20.10.23.
//ViewMOdel Notices Changes and publishes "something changed"

//Send data from the View are "interpreted" and modifies the Model

import SwiftUI

class ViewModel: ObservableObject{  //Observable Objekt
    //Propertys
    //static let emojiArray = ["🚗","🚕","🚙","🚓","🏎️","🚍"] //Static = Global constant
    
    var themes = Themes<String>()
    @Published private var model: Model<String>
    private var currentModelTheme: Theme<String>
    
    init() {
        let currentTheme = Theme<String>(theme: themes.themes.randomElement()!) //themes.themes (bezug 1. auf themes Var und 2. auf themes class)
        let uniqueContent = themes.returnCards(theme: currentTheme) //returns an Array of Card content
        
        //Erstellt eine "Instanz" des Models mit einer festgelegten anzahl an Pairs und füllt das uniqueContent Array mit Karten
        model = Model<String>(numberOfPairsOfCards: themes.returnCards(theme: currentTheme).count) { pairIndex in
                    uniqueContent[pairIndex]
                }
        currentModelTheme = currentTheme //setzt das ganze Theme gleich dem aktuellen theme
    }
    
    
    var cards: Array<Model<String>.Card>{
        return model.cards
    }
    
    
    func createMemoryGame(){
        let currentTheme = Theme<String>(theme: themes.themes.randomElement()!) //themes.themes (bezug 1. auf themes Var und 2. auf themes class)
        let uniqueContent = themes.returnCards(theme: currentTheme) //returns an Array of Card content
        
        //Erstellt eine "Instanz" des Models mit einer festgelegten anzahl an Pairs und füllt das uniqueContent Array mit Karten
        model = Model<String>(numberOfPairsOfCards: themes.returnCards(theme: currentTheme).count) { pairIndex in
            uniqueContent[pairIndex]
        }
        currentModelTheme = currentTheme //setzt das ganze Theme gleich dem aktuellen theme
        self.shuffle() //mischt alles mal etwas durch
    }
    //Only ViewModel can see the Model
    //@Published private var model: Model<String>  = ViewModel.createMemoryGame() //New Instance
    
    //MARK: - Intent(s)
    func choose(_ card: Model<String>.Card){
        model.choose(card)
    }
    
    func getSecondaryColor() -> Color {
        themes.getSecondaryColor(theme: currentModelTheme)
    }
    func getPrimaryColor() -> Color {
        themes.getPrimaryColor(theme: currentModelTheme)
    }
    func getThemeName()->String{
        themes.getThemeName(theme: currentModelTheme)
    }
    

    
    func shuffle(){
        model.shuffle()
    }
}


