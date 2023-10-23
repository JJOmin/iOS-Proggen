//
//  ViewModel.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//

import SwiftUI

class ViewModel: ObservableObject{
    
    @Published private var model: Model<String>
    init() {
        model = Model()
    }
    
    func getNumberOfCards() -> Int{
        return model.getNumberOfCards()
    }
    
    
    
    
}
