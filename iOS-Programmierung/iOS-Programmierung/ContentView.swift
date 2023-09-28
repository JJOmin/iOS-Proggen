//
//  ContentView.swift
//  Peter2
//
//  Created by Leonhard Tilly on 21.09.23.
// Stehengeblieben Lecture 2 1:19:00
//

import SwiftUI

struct ContentView: View {
    var emojis = ["⚽️","🏀","🏈","😀","🥳","😜","🤓","🫣","😭","😰","😶","🫥","😬","😱"]
    @State var emojiCount = 3
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.green)
            Spacer()
            HStack{
                remove
                Spacer()
                add
            }.font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
    }
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
                Image(systemName: "minus.square")
        }
    }
    
    
    var add: some View {
        Button{
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.square")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3).fill()
                Text(content)
                    .font(.largeTitle)
            } else{
                shape.fill()
            }
        }
        .onTapGesture {
            self.isFaceUp = !isFaceUp
        }
    }
}
























































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        ContentView()
            .preferredColorScheme(.light)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
