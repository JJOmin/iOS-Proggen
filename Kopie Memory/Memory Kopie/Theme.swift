//
//  Theme.swift
//  iOS-Programmierung
//
//  Created by Leonhard Tilly on 16.10.23.
// und Hilfestellung von Anna Rieckmann
//

import Foundation

// Definition der Struktur "Theme" mit generischem Typ "Cards"
struct Theme <Cards> {
    // Eigenschaften der Struktur
    let themeName: String // Der Name des Themas
    let cardSet: [Cards] // Ein Array von Kartensymbolen
    let themeColor: String // Die Hauptfarbe des Themas
    let backgroundColor: String // Die Hintergrundfarbe des Themas
    var numberOfPairs: Int // Die Anzahl der Kartensymbol-Paare im Spiel
    
    // Methode, um eine zufällige Auswahl von Karten für das Spiel zurückzugeben
    func returnCardsForGame() -> [Cards] {
        let shuffledCards = cardSet.shuffled() // Karten mischen
        var randomCardsForGame: Array<Cards> = [] // Array für die zufälligen Karten
        
        // Anzahl der ausgewählten Karten auf "numberOfPairs" begrenzen
        if numberOfPairs <= cardSet.count {
            for pairIndex in 0..<numberOfPairs {
                randomCardsForGame.append(shuffledCards[pairIndex]) // Zufällige Karten auswählen
            }
        } else {
            randomCardsForGame = shuffledCards // Wenn mehr Karten benötigt werden als vorhanden sind, alle zurückgeben
        }
        
        return randomCardsForGame // Zufällige Karten zurückgeben
    }
    
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
