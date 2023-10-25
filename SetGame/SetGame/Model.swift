//MODEL
//  Model.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//

import Foundation
import SwiftUI
struct Model<CardContent>{
    
    //Var
    private(set) var numberOfCards: Int //var for the numberOfCards
    private(set) var score: Int //var for the Score
    
    //private(set)
    init (){
        numberOfCards = 81 //5 Karten die wir haben wollen
        score = 0
    }
    
    
    
    
    func getNumberOfCards() -> Int{
        return self.numberOfCards
    }
    
    struct Card: Identifiable {
        //Outside Name "Model.Card"
        var symbolName: String //Form
        var primaryColor: Color //Farbe
        var symbolOpacity: Double //Füllung (nichts, schraffiert, komplett)
        var symbolAmount: Int //Anzahl der Objekte
        
        var isMatched: Bool //Var die beinhaltet ob matched oder nicht
        var isSelected: Bool = false
        var id: Int //zuordnung
    }
    
    func getScore() -> Int{
        return self.score
    }
}
    


