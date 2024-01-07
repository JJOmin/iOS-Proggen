//
//  ScaleContent.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

import Foundation
import SwiftUI
import CoreGraphics

func squareSize(for matrix: [[Int]]) -> CGFloat {
    let sizeMatrix = matrix.count
    let maxSize: CGFloat = 110 // Maximalgröße der Quadrate

    let maxWidth = UIScreen.main.bounds.width - 140 // Breite des Bildschirms abzüglich Randabstand
    let maxHeight = UIScreen.main.bounds.height - 140 // Höhe des Bildschirms abzüglich Randabstand

    let maxPossibleWidth = maxWidth / CGFloat(sizeMatrix)
    let maxPossibleHeight = maxHeight / CGFloat(sizeMatrix)

    let size = min(maxPossibleWidth, maxPossibleHeight, maxSize)
    return size
}

func fontSize(for matrix: [[Int]]) -> CGFloat {
    let squareSizeValue: CGFloat
    if matrix.count == 2 {
        squareSizeValue = squareSize(for: matrix) - (squareSize(for: matrix) / 3) // function to calculate font size for very big Rectangles
    } else {
        squareSizeValue = squareSize(for: matrix) - (squareSize(for: matrix) / 12) // function to calculate font size the other size options
    }
    
    guard let mostDigitsValue = getValueWithMostDigits(from: matrix) else {
        return 5.0 // Default font size or appropriate value
    }
    
    let digitsCount = getDigits(of: mostDigitsValue).count
    let fontSize = squareSizeValue * 0.4 - CGFloat(digitsCount)
    return fontSize
}

// function to get the value with most digits from matrix
func getValueWithMostDigits(from matrix: [[Int]]) -> Int? {
    var maxValue: Int?
    var maxDigitCount = 0

    for row in matrix {
        for value in row {
            let absoluteValue = abs(value)
            let digitCount = "\(absoluteValue)".count

            if digitCount > maxDigitCount {
                maxValue = value
                maxDigitCount = digitCount
            }
        }
    }
    return maxValue
}

func getDigits(of number: Int) -> [Int] {
    let numberString = String(abs(number)) // Convert the absolute value of the number to a string
    let digits = numberString.compactMap { Int(String($0)) } // Extract digits as an array of Int
    return digits
}

func interSquareSpacing(for matrix: [[Int]]) -> CGFloat {
    let sizeMatrix = matrix.count
    let maxSpacing: CGFloat = 8 // Maximaler Abstand zwischen den Quadraten

    // Berechnung des Abstands basierend auf der Anzahl der Elemente in der Matrix
    let spacing = maxSpacing / CGFloat(sizeMatrix)
    return spacing
}

func buttonSize(for matrix: [[Int]]) -> CGFloat {
    let sizeMatrix = matrix.count
    let maxSpacing: CGFloat = 60 // Max button size

    let spacing = maxSpacing / CGFloat(sizeMatrix)
    return spacing
}
