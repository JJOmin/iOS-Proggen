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

    init() {
        self.model = Model(selectedRows: [-1], selectedCols: [-1], size: 3)
    }
    
    var matrix: [[Int]] {
        model.matrix
        
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
    
    func addRemoveFromSelected(col: Int, row: Int, orientation: String) {
        model.addRemoveFromSelected(col: col, row: row, orientation: orientation)
    }
    
    // COLS
    // Adding Cols to select
    func addselectedCol(col: Int) {
        model.addselectedCol(col: col)
    }
    // Removing Cols from selected
    func removeSelectedCol(col: Int) {
        model.removeSelectedCol(col: col)
    }
    
    // ROWS
    // Adding Rows to selected
    func addselectedRow(row: Int) {
        model.addselectedRow(row: row)
    }
    // Removing Rows from selected
    func removeSelectedRow(row: Int) {
        model.removeSelectedRow(row: row)
    }
    
}
