//View
//  ContentView.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var ViewModel: ViewModel //Zugriff
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive (minimum: 65))], content: {
                //ForEach durch alle Elemente die wir erzeugen wollen
                ForEach(0..<ViewModel.getNumberOfCards(), id: \.self) { index in 
                    CardView(primaryColor: .green, secondaryColor: .blue, opacity: 1, width: 50, height: 50, amount: 2)
                        .aspectRatio(2/3, contentMode: .fit)
                    }
            }).padding()
        }
    }
}

//Basic Card erstellen
struct CardView: View{
    let primaryColor: Color
    let secondaryColor: Color
    let opacity: Double
    let width: CGFloat
    let height: CGFloat
    let amount: Int
    //Später var card: SetGame<String>.Card mit allen infos
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 15)
            shape.fill()
            //Pill(primaryColor: primaryColor, opacity: opacity, width: width, height: height, amount: amount)
            //createRectangle(primaryColor: .red, opacity: 0.5, width: 20, height: 20, amount: 3)
            
            
            
            //Pill(primaryColor: primaryColor, opacity: opacity, width: width, height: height, amount: amount)
            
            //Triangle()
             //   .frame(width: width, height: height)
             //   .opacity(opacity)
              //  .foregroundColor(primaryColor)
            
           // Triangle()
            //    .stroke(lineWidth: 0.9)
            //    .frame(width: width, height: height)
             //   .foregroundColor(primaryColor)
            //createTriangle(primaryColor: .green, secondaryColor: .blue, opacity: 1, width: 40, height: 40)
            
            
        }
    }
}


//Do not touch, unless you know why
struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
    let  game = ViewModel()
    ContentView(ViewModel: game).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    ContentView(ViewModel: game).preferredColorScheme(.light)
    }
}

