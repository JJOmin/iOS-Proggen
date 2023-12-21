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
    
    // adding and Removing cols and Rows based on input
    mutating func addRemoveFromSelected(col: Int, row: Int, orientation: String) {
        print(orientation, row, col)
        
        switch orientation {
        case "top":
            // Überprüfe auf Überschneidungen in der gesamten Spalte
            if !selectedCols.contains(col) {
                if selectedRows.isEmpty || selectedRows.allSatisfy({ !selectedCols.contains($0) }) {
                    selectedRows = []
                    selectedCols.append(col)
                    print("1 or 2")
                }
            } else if let index = selectedCols.firstIndex(of: col) {
                selectedCols.remove(at: index)
                print("3")
            }
            
        case "left", "right":
            // Überprüfe auf Überschneidungen in der gesamten Reihe
            if !selectedRows.contains(row) {
                if selectedCols.isEmpty || selectedCols.allSatisfy({ !selectedRows.contains($0) }) {
                    selectedCols = []
                    selectedRows.append(row)
                    print("4 or 5")
                }
            } else if let index = selectedRows.firstIndex(of: row) {
                selectedRows.remove(at: index)
                print("6")
            }
            
        default:
            break
        }
    }
    /*
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
        }*/
}
