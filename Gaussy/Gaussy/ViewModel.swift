//
//  ViewModel.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//
// ViewModel.swift

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var matrix: [[Int]] = []
    @Published var selectedRow: Int? // Property to store the selected row
    @Published private var model: Model
    
    init() {
        // self.matrix = Model.identityMatrix(size: 3)
        self.model = Model(selectedRows: [-1], selectedCols: [-1], size: 3)
        
        // print(Model.getNumberOfNumbers)
    }
    
    // _____Intents____
    var selectedRows: [Int] {
        model.selectedRows
    }
    var selectedCols: [Int] {
        model.selectedCols
    }
}
