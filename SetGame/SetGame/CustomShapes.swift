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







struct CustomShapes: View {
    var body: some View {
        //Diamond().frame(width: 300, height: 200)
        Rectangle().frame(width: 300, height: 300)
        //RoundedRectangle(cornerRadius: 180).frame(width: 300, height: 100)
        Pill(primaryColor: .green, opacity: 0.5, width: 300, height: 300, amount: 2)
        //Squigle()
        //createTriangle(primaryColor: .green, secondaryColor: .blue, opacity: 1, width: 300, height: 300)
}
}

struct createTriangle: View {
    let primaryColor: Color
    let secondaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    //Später var card: SetGame<String>.Card mit allen infos
    
    var body: some View {
            //else if card....
            //else
            Triangle()
                .frame(width: width, height: height)
                .opacity(opacity)
                .foregroundColor(primaryColor)
            
            Triangle()
            .stroke(lineWidth: 0.9)
                .frame(width: width, height: height)
                .foregroundColor(primaryColor)
        }
}

#Preview {
    CustomShapes()
}
