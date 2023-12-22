//
//  Model.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

struct Model {
    var matrix: [[Int]] // = [[1, 2], [3, 4]] // Beispielmatrix
    var selectedRows: [Int]
    var selectedCols: [Int]
    let size: Int
    var selectedLastCol: Int = -1
    var selectedLastRow: Int = -1
    
    init(selectedRows: [Int], selectedCols: [Int], size: Int) {
        self.size = size
        self.selectedRows = []
        self.selectedCols = []
        var identity: [[Int]] = []
        for i in 0..<size {
            var row: [Int] = []
            for j in 0..<size {
                if i == j {
                    row.append(1)
                } else {
                    row.append(0)
                }
            }
            identity.append(row)
        }
        self.matrix = identity
    }
    
    // generating a einheitsmatrix in jeder größe
    func identityMatrix(size: Int) -> [[Int]] {
        var identity: [[Int]] = []
        for i in 0..<size {
            var row: [Int] = []
            for j in 0..<size {
                if i == j {
                    row.append(1)
                } else {
                    row.append(0)
                }
            }
            identity.append(row)
        }
        return identity
    }
    
    func getNumberOfNumbers() -> Int {
        matrix.reduce(0) { $0 + $1.count }
    }
    
    // adding and Removing cols and Rows based on input
    mutating func addRemoveFromSelected(col: Int, row: Int, orientation: String) {
        // print(selectedCols, selectedRows)
        // print(orientation, row, col)
        
        switch orientation {
        case "top":
            if selectedCols.count < 2 {
                if !selectedCols.contains(col) {
                    if selectedRows.isEmpty || selectedRows.allSatisfy({ !selectedCols.contains($0) }) {
                        selectedRows = []
                        selectedCols.append(col)
                        if selectedCols.count == 1 {
                            selectedLastCol = col
                        }
                    }
                } else if let index = selectedCols.firstIndex(of: col) {
                    selectedCols.remove(at: index)
                }
            } else {
                if !selectedCols.contains(col) {
                    // Replaces the first Selected with the last selecteed, if there are more then 2 selected
                    if let index = selectedCols.firstIndex(of: selectedLastCol) {
                        selectedCols.remove(at: index)
                        if selectedCols.count == 1 {
                            selectedLastCol = selectedCols[0]
                        }
                        selectedCols.append(col)
                    }
                } else if let index = selectedCols.firstIndex(of: col) {
                    selectedCols.remove(at: index)
                }
            }
            
        case "left", "right":
            if selectedRows.count < 2 {
                if !selectedRows.contains(row) {
                    if selectedCols.isEmpty || selectedCols.allSatisfy({ !selectedRows.contains($0) }) {
                        selectedCols = []
                        selectedRows.append(row)
                        if selectedRows.count == 1 {
                            selectedLastRow = row
                        }
                    }
                } else if let index = selectedRows.firstIndex(of: row) {
                    selectedRows.remove(at: index)
                }
            } else {
                if !selectedRows.contains(row) {
                    // Replaces the first Selected with the last selecteed, if there are more then 2 selected
                    if let index = selectedRows.firstIndex(of: selectedLastRow) {
                        selectedRows.remove(at: index)
                        if selectedRows.count == 1 {
                            selectedLastRow = selectedRows[0]
                        }
                        selectedRows.append(row)
                    }
                } else if let index = selectedRows.firstIndex(of: row) {
                    selectedRows.remove(at: index)
                }
            }
            
        default:
            break
        }
    }
    
    // Func that swaps the rows
    mutating func swapSelected() {
        if selectedRows.count == 2 {
            let matrixFirst: [Int] = matrix[selectedRows[0]]
            let matrixSecond: [Int] = matrix[selectedRows[1]]
            matrix[selectedRows[0]] = matrixSecond
            matrix[selectedRows[1]] = matrixFirst
            
        } else if selectedCols.count == 2 {
            let matrixFirst: [Int] = matrix[selectedCols[0]]
            let matrixSecond: [Int] = matrix[selectedCols[1]]
            matrix[selectedCols[0]] = matrixSecond
            matrix[selectedCols[1]] = matrixFirst
        }
    }
    
}
