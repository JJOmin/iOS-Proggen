//
//  ContentView.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

import SwiftUI

struct ContentView: View {
    let model = Model() // Hier wird eine Instanz des Models erstellt

    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<model.matrix.count, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(0..<model.matrix[row].count, id: \.self) { col in
                        Text("\(model.matrix[row][col])")
                            .frame(width: squareSize(), height: squareSize())
                            .border(Color.black) // Optional: Rahmen um das Quadrat hinzufügen
                            .padding(5) // Optional: Innenabstand des Quadrats
                    }
                }
            }
        }
        .padding() // Optional: Außenabstand des gesamten Inhalts
    }

    // Funktion zur Berechnung der Größe der Quadrate basierend auf der Anzahl der Objekte in der Matrix
    func squareSize() -> CGFloat {
        let rows = model.matrix.count
        let columns = model.matrix.first?.count ?? 0
        let maxSize: CGFloat = 100 // Maximalgröße der Quadrate

        let maxWidth = UIScreen.main.bounds.width - 40 // Breite des Bildschirms abzüglich Randabstand
        let maxHeight = UIScreen.main.bounds.height - 40 // Höhe des Bildschirms abzüglich Randabstand

        let maxPossibleWidth = maxWidth / CGFloat(columns)
        let maxPossibleHeight = maxHeight / CGFloat(rows)

        let size = min(maxPossibleWidth, maxPossibleHeight, maxSize)
        return size
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
