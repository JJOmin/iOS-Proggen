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
    @Published private var model: Model
    
    @Published var matrix: [[Int]] = [] // Consider initializing this with some data
    
    init() {
        self.model = Model(selectedRows: [-1], selectedCols: [-1], size: 3)
        // Example: Populate matrix with some initial data (3x3 matrix)
        matrix = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]
    }
    
    var selectedRows: [Int] {
        model.selectedRows
    }
    
    var selectedCols: [Int] {
        model.selectedCols
    }
    
    func toggleSelection(row: Int, col: Int) {
        model.toggleSelection(row: row, col: col)
    }
}
