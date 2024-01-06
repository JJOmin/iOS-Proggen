//
//  Model.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

import Foundation
import SwiftUI

enum Difficulty: String {
    case easy = "easy"
    case normal = "normal"
    case hard = "hard"
    case unset = "unset"
}
enum scaleTypeEnum {
    case multiply
    case divide
}
struct PlayerStats: Codable, Identifiable{
    var id: UUID
    let username: String
    let time: Double
    let moves: Int
    //difficulty: Difficulty
}


struct Model {
    var matrix: [[Int]]
    var correctMatrix: [[Int]]
    var selectedRows: [Int]
    var selectedCols: [Int]
    var size: Int
    var selectedLastCol: Int = -1
    var selectedLastRow: Int = -1
    
    var devideByArray: [Int]
    var multiplyByArray: [Int]
    var scalFactor: Int
    
    var maxCharacterCount: Int = 21
    let possibleSizes: [Int] = [2,3,4,5,6]
    
    var scaleType: String
    public var numberOfMoves: Int
    let difficultyLevels: [Difficulty] = [.easy, .normal, .hard]
    var gameRunning: Bool
    var username: String
    var gameTime: TimeInterval = 0.0
    var startTime = Date()
    var time: Double
    var timeFormated: String = ""
    
    let plistName = "HighScores"
    
    
    //Refactoring
    var gameDifficulty: Difficulty
    var gameBackgroundColor: Color = Color.green
    
    var gameSolved: Bool = false
    
    

    
    init(size: Int, difficulty: Difficulty, username: String) {
        self.size = size
        self.username = username
        
        self.gameDifficulty = difficulty
        
        
        self.selectedRows = []
        self.devideByArray = [0, 1, 2, 3, 5, 4, 7, 91]
        self.multiplyByArray = [2, 3, 4, 5, 6, 7, 8, 9, 10]
        self.scalFactor = 1
        self.scaleType = "multiply"
        self.selectedCols = []
        self.numberOfMoves = 0
        
        self.gameRunning = false
        self.time = 0.0
        
        self.matrix = Array(repeating: Array(repeating: 0, count: size), count: size)
        self.correctMatrix = []
        fillMatrix(with: gameDifficulty)
    }
    

    mutating func fillMatrix(with difficulty: Difficulty) {
        // Fill the diagonal with ones
        for i in 0..<size {
            matrix[i][i] = 1
        }
        correctMatrix = matrix // sets the solution matrix to the origin matrix
        
        // Adjust the matrix entries based on difficulty
        var maxIterations = 0
        switch difficulty {
        case .easy:
            maxIterations = Int(Double(size * size) * 0.25)
            
        case .normal:
            maxIterations = Int(Double(size * size) * 0.5)
            
        case .hard:
            maxIterations = Int(Double(size * size) * 0.9)
        case .unset:
            maxIterations = 0
        }
        //print(Int(Double(size * size) * 0.99))
        
        var iterations = 0
        
        while iterations < maxIterations{
            let row = Int.random(in: 0..<size)
            let col = Int.random(in: 0..<size)
            //add
            let matrixFirst: [Int] = matrix[row]
            let matrixSecond: [Int] = matrix[col]
            if matrixFirst.count == matrixSecond.count {
                let resultArray = zip(matrixFirst, matrixSecond).map { $0 + $1 }
                if resultArray.max()! < 100{
                    matrix[col] = resultArray
                }
            }
            
            //Swap
            let rand3 = Int.random(in: 0..<size)
            let rand4 = Int.random(in: 0..<size)
            var matrixT = transposeMatrix(matrix) //transposeMatrix(
            let matrixFirstAdd: [Int] = matrixT[rand3]
            let matrixSecondAdd: [Int] = matrixT[rand4]
            matrixT[rand4] = matrixFirstAdd
            matrixT[rand3] = matrixSecondAdd
            
            matrix = transposeMatrix(matrixT) //Zurücktransposed
            
            //multiply
            let rand1 = Int.random(in: 0..<size)
            let rand2 = Int.random(in: 1..<size)
            let matrixFirstMulty: [Int] = matrix[rand1]
            let multipliedRowMulty = matrixFirstMulty.map { $0 * rand2 }
            if multipliedRowMulty.max()! < 100{
                matrix[rand1] = multipliedRowMulty
            }
            
            //print(matrix)
            iterations += 1
            
        }
        
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
    
    
    
    //REFACTORED
    
    
    // adding and Removing cols and Rows based on input
    mutating func addRemoveFromSelected(col: Int, row: Int, orientation: String) {
        switch orientation {
        case "top":
            if selectedCols.count < 2 {
                if !selectedCols.contains(col) {
                    updateSelectedCols(newCol: col)
                } else {
                    if let index = selectedCols.firstIndex(of: col) {
                        selectedCols.remove(at: index)
                    }
                }
            } else {
                handleMoreThanTwoSelectedCols(col)
            }
            
        case "left", "right":
            if selectedRows.count < 2 {
                if !selectedRows.contains(row) {
                    updateSelectedRows(newRow: row)
                } else {
                    if let index = selectedRows.firstIndex(of: row) {
                        selectedRows.remove(at: index)
                    }
                }
            } else {
                handleMoreThanTwoSelectedRows(row)
            }
            
        default:
            break
        }
    }

    private mutating func updateSelectedCols(newCol: Int) {
        if selectedRows.isEmpty || selectedRows.allSatisfy({ !selectedCols.contains($0) }) {
            selectedRows = []
            selectedCols.append(newCol)
            if selectedCols.count == 1 {
                selectedLastCol = newCol
            }
        }
    }

    private mutating func handleMoreThanTwoSelectedCols(_ col: Int) {
        if !selectedCols.contains(col), let index = selectedCols.firstIndex(of: selectedLastCol) {
            selectedCols.remove(at: index)
            if selectedCols.count == 1 {
                selectedLastCol = selectedCols[0]
            }
            selectedCols.append(col)
        } else if let index = selectedCols.firstIndex(of: col) {
            selectedCols.remove(at: index)
        }
    }

    private mutating func updateSelectedRows(newRow: Int) {
        if selectedCols.isEmpty || selectedCols.allSatisfy({ !selectedRows.contains($0) }) {
            selectedCols = []
            selectedRows.append(newRow)
            if selectedRows.count == 1 {
                selectedLastRow = newRow
            }
        }
    }

    private mutating func handleMoreThanTwoSelectedRows(_ row: Int) {
        if !selectedRows.contains(row), let index = selectedRows.firstIndex(of: selectedLastRow) {
            selectedRows.remove(at: index)
            if selectedRows.count == 1 {
                selectedLastRow = selectedRows[0]
            }
            selectedRows.append(row)
        } else if let index = selectedRows.firstIndex(of: row) {
            selectedRows.remove(at: index)
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
                var matrixT = transposeMatrix(matrix)
                
                let matrixFirst: [Int] = matrixT[selectedCols[0]]
                let matrixSecond: [Int] = matrixT[selectedCols[1]]
                matrixT[selectedCols[0]] = matrixSecond
                matrixT[selectedCols[1]] = matrixFirst
                matrix = transposeMatrix(matrixT) //Zurücktransposed
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
            }
        }
    }
    
    mutating func addMove(){
        numberOfMoves += 1
        //print(timeTracking())
        isGaussSolved()
    }
    

    mutating func setSize(newSize: Int) {
        self.size = newSize
    }
    
    
    
    // Funktion zur Verfolgung der vergangenen Spielzeit als formatierten String
    mutating func timeTracking(){
            // Aktuelle Zeit abrufen
            let timeNow = Date()
            // Berechne die vergangene Spielzeit
            self.time = timeNow.timeIntervalSince(self.startTime)
            
            // Formatter für die Darstellung der Spielzeit
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            formatter.allowedUnits = [.minute, .second, .nanosecond]
            formatter.zeroFormattingBehavior = .pad
            
            // Rückgabe der formatierten Spielzeit
            //print(self.time)
            //self.timeFormated = formatter.string(from: self.time) ?? "00"
            
            let totalSeconds: TimeInterval = self.time
            
            let hours = Int(totalSeconds / 3600)
            let remainingSecondsAfterHours = totalSeconds - TimeInterval(hours * 3600)
            
            let minutes = Int(remainingSecondsAfterHours / 60)
            let remainingSecondsAfterMinutes = remainingSecondsAfterHours - TimeInterval(minutes * 60)
            
            let seconds = Int(remainingSecondsAfterMinutes)
            let milliseconds = Int((remainingSecondsAfterMinutes - Double(seconds)) * 100)
            
            // Use String(format:) to format minutes with leading zeros if needed
            let formattedMinutes = String(format: "%02d", minutes)
            let formatedSeconds = String(format: "%02d", seconds)
            let formatedMilliseconds = String(format: "%02d", milliseconds)
        
        
            if hours <= 0{
                if minutes <= 0{
                    self.timeFormated = "\(formatedSeconds):\(formatedMilliseconds)"
                } else {
                    self.timeFormated = "\(formattedMinutes):\(formatedSeconds)"
                }
            } else {
                self.timeFormated = "\(hours):\(formattedMinutes):\(formatedSeconds)"
            }
    }
    
    
    func formatSecondsToString(timeToFormat: Double) -> String{
        let totalSeconds: TimeInterval = timeToFormat
        
        let hours = Int(totalSeconds / 3600)
        let remainingSecondsAfterHours = totalSeconds - TimeInterval(hours * 3600)
        
        let minutes = Int(remainingSecondsAfterHours / 60)
        let remainingSecondsAfterMinutes = remainingSecondsAfterHours - TimeInterval(minutes * 60)
        
        let seconds = Int(remainingSecondsAfterMinutes)
        let milliseconds = Int((remainingSecondsAfterMinutes - Double(seconds)) * 100)
        
        // Use String(format:) to format minutes with leading zeros if needed
        let formattedMinutes = String(format: "%02d", minutes)
        let formatedSeconds = String(format: "%02d", seconds)
        let formatedMilliseconds = String(format: "%02d", milliseconds)
        let formatedHours = String(format: "%02d", hours)
        
        if hours <= 0{
            if minutes <= 0{
                return("\(formatedSeconds) sec. \(formatedMilliseconds) msec.")
            } else {
                return("\(formattedMinutes) min. \(formatedSeconds) sec.")
            }
        } else {
            return("\(hours) hrs. \(formattedMinutes) min. \(formatedSeconds) sec.")
        }
        //return("\(formatedHours):\(formattedMinutes):\(formatedSeconds):\(formatedMilliseconds)")
    }
    


    
    //function to Transpose a matrix to easily get the cols
    func transposeMatrix(_ matrix: [[Int]]) -> [[Int]] {
        guard !matrix.isEmpty else {
            return []
        }

        let rowCount = matrix.count
        let colCount = matrix[0].count

        var transposedMatrix = Array(repeating: Array(repeating: 0, count: rowCount), count: colCount)

        for i in 0..<rowCount {
            for j in 0..<colCount {
                transposedMatrix[j][i] = matrix[i][j]
            }
        }
        return transposedMatrix
    }
    
    
    mutating func isGaussSolved(){
        if matrix == correctMatrix{
            matrix = correctMatrix
            gameRunning = false
            gameSolved = true
            removeAllSelected()
            print("Game Solved")
        }
    }
    
    

}
