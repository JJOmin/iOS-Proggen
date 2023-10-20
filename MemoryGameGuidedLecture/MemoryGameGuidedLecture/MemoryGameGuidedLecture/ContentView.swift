//
//  ContentView.swift
//  MemoryGameGuidedLecture
//
//  Created by Leonhard Tilly on 19.10.23.
//Lecture 1 1:11:30

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            VStack {
                
            }
            .padding(1)
            }
    }
}




//Settings for Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
