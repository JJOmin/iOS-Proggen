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
    static let emojiArray = ["🚗","🚕","🚙","🚓","🏎️","🚍"] //Static = Global constant
    
    static func createMemoryGame()-> Model<String>{
        Model<String>(numberOfPairOfCards: 4) {pairIndex in
            emojiArray[pairIndex]
        }
    }
    //Only ViewModel can see the Model
    

    
    @Published private var model: Model<String>  = ViewModel.createMemoryGame() //New Instance
    
    //Initilizer
   
    
    var cards: Array<Model<String>.Card>{
        return model.cards
    }
    
    
    //MARK: - Intent(s)
    func choose(_ card: Model<String>.Card){
        model.choose(card)
    }
    

}


