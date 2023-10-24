//
//  CustopShapes.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//


import SwiftUI

struct Triangle: Shape{ //Create the Triangle
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape{ //Create the Triangle
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) //done
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) //
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))

        }
    }
}

struct Pill: View {
    let primaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    let amount: Int
    
    var body: some View {
        VStack(spacing: 10) { // Adjust spacing according to your needs
            ForEach(0..<amount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 180)
                    .frame(width: width, height: height/3)
                    .foregroundColor(primaryColor)
                    .opacity(opacity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 180)
                            .stroke(primaryColor, lineWidth: 2)
                    )
            }
        }
    }
}

