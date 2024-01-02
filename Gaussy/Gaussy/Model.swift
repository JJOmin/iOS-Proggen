//
//  Model.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

import Foundation

struct Model {
    var matrix: [[Int]] // = [[1, 2], [3, 4]] // Beispielmatrix
    var selectedRows: [Int]
    var selectedCols: [Int]
    var size: Int
    var selectedLastCol: Int = -1
    var selectedLastRow: Int = -1
    
    var devideByArray: [Int]
    var multiplyByArray: [Int]
    var scalFactor: Int
    var difficulty: String
    var maxCharacterCount: Int = 21
    let possibleSizes: [Int] = [2,3,4,5,6]
    
    var scaleType: String
    public var numberOfMoves: Int
    var difficultyLevels: [String]
    var gameRunning: Bool
    var username: String
    
    
    init(size: Int, difficulty: String, username: String) {
        self.size = size
        self.username = username
        self.difficulty = difficulty
        
        self.selectedRows = []
        self.devideByArray = [0, 1, 2, 3, 5, 4, 7, 91]
        self.multiplyByArray = [2, 3, 4, 5, 6, 7, 8, 9]
        self.scalFactor = 1 // factor that can be multiplyed or devided with the one Row
        self.scaleType = "multiply"
        self.selectedCols = []
        self.numberOfMoves = 0
        self.difficultyLevels = ["easy", "normal", "hard"]
        self.gameRunning = false
        
        
        enum Difficulty {
            case easy
            case normal
            case hard
        }
        /*
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
        self.matrix = identity*/
        var matrix = Array(repeating: Array(repeating: 0, count: size), count: size)

            // Diagonale der Matrix mit Einsen füllen
            for i in 0..<size {
                matrix[i][i] = 1
            }

            // Zufällige Anpassung der Einträge für die Schwierigkeit
            var maxIterations = 0
            switch difficulty {
            case "easy":
                maxIterations = Int(Double(size * size) * 0.25) // Adjust the factor for 'easy'
            case "normal":
                maxIterations = Int(Double(size * size) * 0.5) // Adjust the factor for 'normal'
            case "hard":
                maxIterations = Int(Double(size * size) * 0.99) // Adjust the factor for 'hard'
            default:
               break
            }

            var iterations = 0
            while iterations < maxIterations {
                let row = Int.random(in: 0..<size)
                let col = Int.random(in: 0..<size)
                matrix[row][col] = Int.random(in: 1...9) // Verwendung von Integer-Werten zwischen 1 und 9
                iterations += 1
            }
        self.matrix = matrix
    }
    
    
    mutating func createNewMatrix(){
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
    
    //function that resetts all Rows/cols -> used for Cancel Button in Scaling
    mutating func removeAllSelected() {
        selectedRows = []
        selectedCols = []
        selectedLastRow = -1
        selectedLastCol = -1
    }
    
    mutating func scaleRow(value: Int){
        if scaleType == "divide" {
            //print("DEVIDE NOW")
            if  value != 0 {
                let matrixFirst: [Int] = matrix[selectedRows[0]]
                let dividedRow = matrixFirst.map { $0 / value }
                matrix[selectedRows[0]] = dividedRow
                addMove()
            }
            
        } else if scaleType == "multiply"{
            let matrixFirst: [Int] = matrix[selectedRows[0]]
            let multipliedRow = matrixFirst.map { $0 * value }
            matrix[selectedRows[0]] = multipliedRow
            addMove()
        }
        removeAllSelected() //necessary to ensure that new matrix is used everywhere and not the old one
    }
    
    // Func that swaps the rows
    mutating func swapSelected() {
            if selectedRows.count == 2 {
                let matrixFirst: [Int] = matrix[selectedRows[0]]
                let matrixSecond: [Int] = matrix[selectedRows[1]]
                matrix[selectedRows[0]] = matrixSecond
                matrix[selectedRows[1]] = matrixFirst
                addMove()
                
            } else if selectedCols.count == 2 {
                let matrixFirst: [Int] = matrix[selectedCols[0]]
                let matrixSecond: [Int] = matrix[selectedCols[1]]
                matrix[selectedCols[0]] = matrixSecond
                matrix[selectedCols[1]] = matrixFirst
                addMove()
            }
    }
    
    // addieren von reihen
    mutating func addRows() {
        if selectedRows.count == 2 {
            let matrixFirst: [Int] = matrix[selectedRows[0]]
            let matrixSecond: [Int] = matrix[selectedRows[1]]
            if matrixFirst.count == matrixSecond.count {
                let resultArray = zip(matrixFirst, matrixSecond).map { $0 + $1 }
                matrix[selectedRows[1]] = resultArray
                addMove()
            }
        }
    }
    
    // subtrahieren von reihen
    mutating func subRows() {
        if selectedRows.count == 2 {
            let matrixFirst: [Int] = matrix[selectedRows[0]]
            let matrixSecond: [Int] = matrix[selectedRows[1]]
            
            if matrixFirst.count == matrixSecond.count {
                let resultArray = zip(matrixSecond, matrixFirst).map { $0 - $1 }
                matrix[selectedRows[1]] = resultArray
                addMove()
            }
        }
    }
    
    // function that calculates the scaling factors for devision
    mutating func getDivider() {
        devideByArray = [] // Reset possible dividers
        var foundDivisors = 0 // Counter to track the number of found divisors
        
        if selectedRows.count == 1 {
            let matrixScaled: [Int] = matrix[selectedRows[0]]
            let nonZeroValues = matrixScaled.filter { $0 != 0 }
            
            for divisor in 1...(nonZeroValues.max() ?? 1) where foundDivisors < 5 {
                if nonZeroValues.allSatisfy({ $0.isMultiple(of: divisor) }) {
                    devideByArray.append(divisor)
                    foundDivisors += 1 // Increment the counter
                    
                }
            }//; print("Divisor", devideByArray)
        }
    }
    
    mutating func addMove(){
        numberOfMoves += 1
    }
    //
    func createGameMatrix(_ size: Int, difficulty: Double) -> [[Int]] {
        var matrix = Array(repeating: Array(repeating: 0, count: size), count: size)

        // Diagonale der Matrix mit Einsen füllen
        for i in 0..<size {
            matrix[i][i] = 1
        }

        // Zufällige Anpassung der Einträge für die Schwierigkeit
        let maxIterations = Int(Double(size * size) * difficulty)
        var iterations = 0

        while iterations < maxIterations {
            let row = Int.random(in: 0..<size)
            let col = Int.random(in: 0..<size)
            matrix[row][col] = Int.random(in: 1...9) // Verwendung von Integer-Werten zwischen 1 und 9
            iterations += 1
        }

        return matrix
    }
    
    

    mutating func setSize(newSize: Int) {
        self.size = newSize
    }


}
