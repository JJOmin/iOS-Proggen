//MODEL
//  Model.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//

import Foundation
struct Model<CardContent>{
    
    //Var
    private(set) var numberOfCards: Int //var for the numberOfCards
    private(set) var score: Int //var for the Score
    
    //private(set)
    init (){
        numberOfCards = 5 //5 Karten die wir haben wollen
        score = 0
    }
    
    
    
    
    func getNumberOfCards() -> Int{
        return self.numberOfCards
    }
    
    struct Card: Identifiable {
        //Outside Name "Model.Card"
        var primaryColor: String //Farbe
        var isMatched: Bool //Var die beinhaltet ob matched oder nicht
        var symbolShape: String //Form
        var symbolAmount: Int //Anzahl der Objekte
        var symbolFill: String //Füllung (nichts, schraffiert, komplett)
        var isSelected: Bool = false
        var content: CardContent // Dont Care Type (have to be anounced in struct)
        var id: Int //zuordnung
    }
    
    func getScore() -> Int{
        return self.score
    }
}
    


