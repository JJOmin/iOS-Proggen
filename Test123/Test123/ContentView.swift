import SwiftUI

struct CheckboxView: View {
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            // Implement your action here
        }) {
            Text(self.isSelected ? "✔️" : "◻️")
                .font(.title)
        }
        .frame(width: 25, height: 25)
        .foregroundColor(self.isSelected ? .blue : .black)
        .padding(5)
        .background(Color.clear)
        .border(Color.black)
    }
}

struct ContentView: View {
    @ObservedObject var gameData = GameData()
    
    var body: some View {
        VStack {
            VStack {
                Text("Gauss Elimination Game").font(.title)
                Text("Score: 000")
            }.padding(10)
            
            VStack {
                ForEach(gameData.numbers.indices, id: \.self) { rowIndex in
                    HStack {
                        CheckboxView(isSelected: self.$gameData.selectedRows[rowIndex])
                        
                        ForEach(self.gameData.numbers[rowIndex], id: \.self) { number in
                            Text("\(number)")
                                .font(.title)
                                .frame(width: 80, height: 80)
                                .border(Color.black)
                                .background(
                                    self.gameData.selectedRows[rowIndex] ? Color.yellow : Color.clear
                                )
                                .onTapGesture {
                                    self.gameData.selectedRows[rowIndex].toggle()
                                }
                        }
                    }
                }
                Spacer()
            }.padding(10)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

