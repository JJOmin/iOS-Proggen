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
    
    // ____ROWS___
    // Add Row to selected Rows
    mutating func addselectedRow(row: Int) {
        selectedRows.append(row)
    }
    // Removing Row from Selected List
    mutating func removeSelectedRow(row: Int) {
        if let index = selectedRows.firstIndex(of: row) {
            selectedRows.remove(at: index)
        }
    }
    
    // ___COLS___
    // Add Col to the selected Cols
    mutating func addselectedCol(col: Int) {
        selectedCols.append(col)
    }
    // Removing Col from Selected List
    mutating func removeSelectedCol(col: Int) {
        if let index = selectedCols.firstIndex(of: col) {
            selectedCols.remove(at: index)
        }
    }
    
    // adding and Removing cols and Rows based on input
    mutating func addRemoveFromSelected(col: Int, row: Int, orientation: String) {
        print(orientation, row, col)
        if orientation == "top" && selectedCols.contains(col) == false {
            if selectedRows.isEmpty { // wenn keine Reihe ausgewählt ist
                selectedCols.append(col) // wähle die angecklickte Spalte aus
                print("1")
            } else if selectedRows.contains(row) { // wenn die angecklickte Spalte teil einer ausgewählten zeile ist
                selectedRows = [] // dann entfernte die Ausgewählten elemente aus selected
                selectedCols.append(col)
                print("2")
            }
        } else if orientation == "top" && selectedCols.contains(col) == true {
            if let index = selectedCols.firstIndex(of: col) {
                selectedCols.remove(at: index)
                print("3")
            }
            
        } else if (orientation == "left" || orientation == "right") && selectedRows.contains(row) == false {
            if selectedCols.isEmpty { // wenn keine Reihe ausgewählt ist
                selectedRows.append(row) // wähle die angecklickte Spalte aus
                print("4")
            } else if selectedCols.contains(col) { // wenn die angecklickte Spalte teil einer ausgewählten zeile ist
                selectedCols = [] // dann entfernte die Ausgewählten elemente aus selected
                selectedRows.append(row)
                print("5")
            }
        } else if orientation == "left" && selectedRows.contains(row) == true {
            if let index = selectedRows.firstIndex(of: row) {
                selectedRows.remove(at: index)
                print("6")
            }
        }
    }
    // Work in progress
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
