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
        self.model = Model(selectedRows: [-1], selectedCols: [-1], size: 4)
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
    
    var devideByArray: [Int] {
        model.devideByArray
    }
    
    var multiplyByArray: [Int] {
        model.multiplyByArray
    }
    
    var scaleType: String {
        model.scaleType
    }
    
    var numberOfMoves: Int{
        model.numberOfMoves
    }
    /*
    func toggleSelection(row: Int, col: Int) {
        model.toggleSelection(row: row, col: col)
    }*/
    
    func addRemoveFromSelected(col: Int, row: Int, orientation: String) {
        model.addRemoveFromSelected(col: col, row: row, orientation: orientation)
    }
    
    func swapSelected() {
        model.swapSelected()
    }
    
    func addRows() {
        model.addRows()
    }
    func subRows() {
        model.subRows()
    }
    
    func getDivider() {
        model.getDivider()
    }
    
    func setScaleType(currentType: String) {
        model.scaleType = currentType
    }
    
    func removeAllSelected(){
        model.removeAllSelected()
    }
    
    func scaleRow(value: Int){
        model.scaleRow(value: value)
    }
}
