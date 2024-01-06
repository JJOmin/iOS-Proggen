//
//  draging.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 06.01.24.
//

import Foundation
import SwiftUI
struct dragging: View {
    @State private var offset: CGSize = .zero
    @State private var message: String = ""

    var body: some View {
        VStack {
            Text(message)
                .padding()

            HStack {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 150, height: 150)
                    //.offset(offset)
                    .gesture(dragGesture)
            }
        }
    }

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
            .onEnded { value in
                self.offset = .zero
                
                // Calculate the direction of the swipe
                let horizontalDistance = value.translation.width
                let verticalDistance = value.translation.height
                
                if horizontalDistance > 0 && abs(horizontalDistance) > abs(verticalDistance) {
                    // Swiped from left to right
                    print("left to right")
                } else if horizontalDistance < 0 && abs(horizontalDistance) > abs(verticalDistance) {
                    // Swiped from right to left
                    print("right to left")
                } else {
                    print("other")
                }
            }
    }
}


/*
struct dragging: View {
    @State private var firstRectPosition: CGSize = .zero
    @State private var secondRectPosition: CGSize = .zero
    @State private var dragging: Bool = false

    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .offset(firstRectPosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.dragging = true
                            self.firstRectPosition = value.translation
                        }
                        .onEnded { value in
                            if self.dragging {
                                self.firstRectPosition = .zero
                                let distance = self.distance(from: self.firstRectPosition, to: self.secondRectPosition)
                                if distance < 50 {
                                    self.secondRectPosition = .zero // Drop the rectangle onto the second rectangle
                                }
                                self.dragging = false
                            }
                        }
                )
            
            Rectangle()
                .frame(width: 150, height: 150)
                .foregroundColor(.red)
                .offset(secondRectPosition)
        }
    }

    func distance(from point1: CGSize, to point2: CGSize) -> CGFloat {
        let dx = point2.width - point1.width
        let dy = point2.height - point1.height
        return sqrt(dx * dx + dy * dy)
    }
}
*/
