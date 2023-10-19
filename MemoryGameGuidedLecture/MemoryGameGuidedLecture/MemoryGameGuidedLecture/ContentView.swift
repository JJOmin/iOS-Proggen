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
                Image(systemName: "plus.rectangle")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("First Words").padding(20)
            }
            .padding(1)
            }
    }
}



















//Settings for Preview
struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
