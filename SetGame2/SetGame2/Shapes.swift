//
//  Shapes.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 28.10.23.
//

import SwiftUI

struct DiamondShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            
            //1. idee das ganze um zu setzen, einfacher war aber eine raute einfach nur zu stauchen
            /*
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY+rect.midY/2))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY-rect.midY/2))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
           */
        }
    }
}

struct Diamond: View{
    let primaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    let amount: Int
    let spacing: CGFloat
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<amount, id: \.self) { index in
                DiamondShape()
                    .frame(width: width*2, height: height)
                    .foregroundColor(primaryColor)
                    .opacity(opacity)
                    .overlay(
                        DiamondShape()
                            .stroke(primaryColor, lineWidth: 2)
                    )
            }
        }
    }
}

struct Pill: View {
    let primaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    let amount: Int
    let spacing: CGFloat
    
    var body: some View {
        VStack(spacing: spacing) { // Adjust spacing according to your needs
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

struct Rectangle: View {
    let primaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    let amount: Int
    let spacing: CGFloat
    
    var body: some View {
        VStack(spacing: spacing) { // Adjust spacing according to your needs
            ForEach(0..<amount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: width, height: height)
                    .foregroundColor(primaryColor)
                    .opacity(opacity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(primaryColor, lineWidth: 2)
                    )
            }
        }
    }
}
