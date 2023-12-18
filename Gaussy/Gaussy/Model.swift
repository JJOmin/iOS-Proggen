//
//  Model.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

// Model.swift

// Model.swift

struct Model {
    var matrix: [[Int]] = [[1, 2], [3, 4]] // Beispielmatrix
    // Funktion zur Generierung einer Einheitsmatrix mit der angegebenen Größe
    static func identityMatrix(size: Int) -> [[Int]] {
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
}
