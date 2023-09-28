//
//  ContentView.swift
//
//  Created by Leonhard Tilly on 28.09.23.
// Stehengeblieben Lecture 2 Fertig
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["⚽️","🏀","🏈","😀","🥳","😜","🤓","🫣","😭","😰","😶","🫥","😬","😱"]
    let animalArray = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐵","🙈","🙉","🙊","🐒","🦆","🐣","🦅","🐴","🐗","🐺"]
    let fruitArray = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅"]
    let vegetableArray = ["🍆","🥑","🫛","🥦","🥬","🥒","🌶️","🫑","🌽","🥕","🫒","🧄","🧅","🥔","🍠","🫚"]
    @State var emojiCount = 14
    @State var themeTitle = ""
    
    var body: some View {
        VStack{
            Text("Memory! - " + themeTitle).font(.largeTitle)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.green)
            Spacer()
            HStack{
                animal
                Spacer()
                fruit
                Spacer()
                vegetable
                
            }.font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
    }
    
    //Randomizer
    func generateRandomNumber() -> Int {
        let lowerBound = 9  // Die untere Grenze (einschließlich 9)
        let upperBound = 17 // Die obere Grenze (ausschließlich 17)
        
        let randomNumber = Int(arc4random_uniform(UInt32(upperBound - lowerBound))) + lowerBound
        return randomNumber
    }
    
    
    
    //Buttons
    
    var animal: some View {
        Button(action: {
            themeTitle = "Animals"
            emojis = animalArray
            emojis.shuffle()
            emojiCount = generateRandomNumber()
            
            }, label: {
                VStack{
                    Image (systemName: "pawprint")
                    Text("Animals")
                        .font(.body)
                }
        })
    }
    
    var fruit: some View {
        Button(action: {
            themeTitle = "Fruits"
            emojis = animalArray
            emojis.shuffle()
            emojiCount = generateRandomNumber()
            }, label: {
                VStack{
                    Image (systemName: "apple.logo")
                    Text("Fruits")
                        .font(.body)
                }
        })
    }
    
    var vegetable: some View {
        Button(action: {
            themeTitle = "Vegetables"
            emojis = vegetableArray
            emojis.shuffle()
            emojiCount = generateRandomNumber()
            }, label: {
                VStack{
                    Image (systemName: "carrot")
                    Text("Vegies")
                        .font(.body)
                }
        })
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
                shape.strokeBorder(lineWidth: 3)
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
