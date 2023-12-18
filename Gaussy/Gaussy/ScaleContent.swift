//
//  ScaleContent.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

import Foundation
import SwiftUI

func squareSize(for matrix: [[Int]]) -> CGFloat {
    let sizeMatrix = matrix.count
    let maxSize: CGFloat = 80 // Maximalgröße der Quadrate

    let maxWidth = UIScreen.main.bounds.width - 40 // Breite des Bildschirms abzüglich Randabstand
    let maxHeight = UIScreen.main.bounds.height - 40 // Höhe des Bildschirms abzüglich Randabstand

    let maxPossibleWidth = maxWidth / CGFloat(sizeMatrix)
    let maxPossibleHeight = maxHeight / CGFloat(sizeMatrix)

    let size = min(maxPossibleWidth, maxPossibleHeight, maxSize)
    return size
}

func fontSize(for matrix: [[Int]]) -> CGFloat {
    let squareSizeValue = squareSize(for: matrix)
    let fontSize = squareSizeValue * 0.5 // Adjust the multiplier to set the desired font size
    return fontSize
}
