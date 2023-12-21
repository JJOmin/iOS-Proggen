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
    
    init(selectedRows: [Int], selectedCols: [Int], size: Int) {
        
        self.size = size
        self.selectedRows = selectedRows
        self.selectedCols = selectedCols
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
    
    // Add Row to selected Rows
    mutating func addselectedRow(newRow: Int) {
        selectedRows.append(newRow)
    }
    // Removing Element from Selected List
    mutating func removeSelectedCol(row: Int) {
        if let index = selectedRows.firstIndex(of: row) {
            selectedRows.remove(at: index)
        }
    }
    
    // Add Col to the selected Cols
    mutating func addselectedCol(col: Int) {
        selectedCols.append(col)
    }
    // Removing Element from Selected List
    mutating func removeSelectedCol(col: Int) {
        if let index = selectedCols.firstIndex(of: col) {
            selectedCols.remove(at: index)
        }
    }
    
    mutating func toggleSelection(row: Int, col: Int) {
            if selectedRows.contains(row) {
                if let index = selectedRows.firstIndex(of: row) {
                    selectedRows.remove(at: index)
                }
            } else {
                selectedRows.append(row)
            }
            
            if selectedCols.contains(col) {
                if let index = selectedCols.firstIndex(of: col) {
                    selectedCols.remove(at: index)
                }
            } else {
                selectedCols.append(col)
            }
        }
}
