//
//  CustopShapes.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//


import SwiftUI





//Erstmal drin gelassen, da Tutorial

struct CreateDiamond: Shape{ //Create the Triangle
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) //done
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) //
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))

        }
    }
}

struct CreatePill: View {
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

struct CreateRectangle: View {
    let primaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    let amount: Int
    
    var body: some View {
        VStack(spacing: 10) { // Adjust spacing according to your needs
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



struct Symbol <Cards> {
    // Eigenschaften der Struktur
    let primaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    let amount: Int
    
    // Initialisierermethode, um ein Theme-Objekt von einem vorhandenen Theme zu erstellen
    init(symbol: Symbol<Cards>) {
        self.primaryColor = symbol.primaryColor
        self.opacity = symbol.opacity
        self.width = symbol.width
        self.height = symbol.height
        self.amount = symbol.amount
    }
    
    // Initialisierermethode, um ein neues Theme-Objekt zu erstellen
    init(primaryColor: Color, opacity: Double, width: CGFloat, height: CGFloat, amount: Int) {
        self.primaryColor = primaryColor
        self.opacity = opacity
        self.width = width
        self.height = height
        self.amount = amount
    }
    
}

      

class Symbols<Cards>{
    var symbols = [["CreatePill", "CreateRectangle", "CreateDiamond"],
                   ["green", "blue", "pink"],
                   [0.0, 0.5, 1.0],
                   [1,2,3]]
    
    //methode zum konvertieren von String Farben in Color Type
    func getColor(colorString : String) -> Color {
        let colorMapping: [String: Color] = [
            "white": .white,
            "red": .red,
            "orange": .orange,
            "blue": .blue,
            "green": .green,
            "gray": .gray,
            "purple": .purple,
            "pink": .pink,
            "yellow": .yellow,
            "black": .black,
            "indigo": .indigo,
            "mint": .mint
        ]
        //wenn farbe vorhanden, dann return als Color Type ansonsten red
        return colorMapping[colorString] ?? .red
    }
    
    
    func getSymbolNames() -> Array<Any>{
        return symbols[0]
    }
    
    func getSymbolColors() -> Array<Any>{
        return symbols[1]
    }
    
    func getSymbolOpacitys() -> Array<Any>{
        return symbols[2]
    }
    func getSymbolAmounts() -> Array<Any>{
        return symbols[3]
    }
}


