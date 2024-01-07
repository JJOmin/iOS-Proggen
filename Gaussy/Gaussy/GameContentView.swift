// ContentView.swift

import SwiftUI

struct GameContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedNumber = 1
    @State private var selectedOption = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var backButtonOpacity: Double = 0.0 // Initial opacity for animation
    @State private var showHighScoreView = false // State variable to control HighScoreView presentation
    
    @State private var topColor: Color = .green // Default color
    @State private var offset: CGSize = .zero
    @State private var message: String = ""
    
    func selectableCircle(col: Int, row: Int, orientation: String) -> some View {
        let isColSelected: Bool = viewModel.selectedCols.contains(col)
        let isRowSelected: Bool = viewModel.selectedRows.contains(row)
        let rowAndTop: Bool = isColSelected && (orientation == "top")
        let colAndLeftRight: Bool = isRowSelected && (orientation == "left" || orientation == "right")
        
        let circleColor: Color = rowAndTop || colAndLeftRight ? Color.yellow : Color.gray
        
        return Circle()
            .fill(circleColor)
            .frame(width: 20, height: 20)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2) // Add a black border with a width of 2
            )
            .onTapGesture {
                withAnimation {
                    viewModel.addRemoveFromSelected(col: col, row: row, orientation: orientation)
                }
                self.viewModel.getDivider()
            }
            .gesture(DragGesture()
                        .onChanged { value in
                            // Handle the drag gesture for individual circles here
                            // For example, you can print the position of the dragged circle
                            print(orientation)
                            //print("Dragging circle at row: \(row), col: \(col)")
                        }
                        .onEnded { value in
                            self.offset = .zero
                            
                            // Calculate the direction of the swipe
                            let horizontalDistance = value.translation.width
                            let verticalDistance = value.translation.height
                            
                            if (horizontalDistance > 0 && abs(horizontalDistance) > abs(verticalDistance)) && orientation == "top" {
                                // Swiped from left to right
                                if col + 1 <= self.viewModel.size - 1 {
                                    //print("Jap geht")
                                    self.viewModel.swapMatrixCols(m1Col: col, m2Col: col+1)
                                    
                                    //print()
                                }
                                
                            } else if (horizontalDistance < 0 && abs(horizontalDistance) > abs(verticalDistance)) && orientation == "top" {
                                if col - 1 >= 0 {
                                    //print("Noice")
                                    self.viewModel.swapMatrixCols(m1Col: col, m2Col: col-1)
                                } else {
                                    //print("geht nicht 2")
                                }
                            } else if verticalDistance > 0 && abs(verticalDistance) > abs(horizontalDistance) && (orientation == "left" || orientation == "right"){
                                //for top to bottom swap
                                if row + 1 <= self.viewModel.size - 1 { //if row+1 exists
                                    self.viewModel.swapMatrixRows(m1Row: row, m2Row: row+1) //swap row and row beneath
                                }
                            } else if verticalDistance < 0 && abs(verticalDistance) > abs(horizontalDistance) && (orientation == "left" || orientation == "right"){
                                //print("Swiped from bottom to top")
                                if row - 1 >= 0 { //if row-1 greater than 0 (if a row above exists)
                                    self.viewModel.swapMatrixRows(m1Row: row, m2Row: row-1) //swap row and row above
                                }
                            } else {
                                print("FAIL")
                            }
                            // Handle the end of the drag gesture if needed
                        }
            )
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
            .onEnded { value in
                self.offset = .zero
                
                // Calculate the direction of the swipe
                let horizontalDistance = value.translation.width
                let verticalDistance = value.translation.height
                
                if horizontalDistance > 0 && abs(horizontalDistance) > abs(verticalDistance) {
                    // Swiped from left to right
                    print("left to right")
                } else if horizontalDistance < 0 && abs(horizontalDistance) > abs(verticalDistance) {
                    // Swiped from right to left
                    print("right to left")
                }  else if verticalDistance > 0 && abs(verticalDistance) > abs(horizontalDistance) {
                    print("Swiped from top to bottom")
                } else if verticalDistance < 0 && abs(verticalDistance) > abs(horizontalDistance) {
                    print("Swiped from bottom to top")
                } else {
                    print("other")
                }
            }
    }
    
    func buttonsTop() -> some View {
        return ForEach(0..<viewModel.matrix.count, id: \.self) { row in
            HStack(spacing: (squareSize(for: viewModel.matrix) - 20 + interSquareSpacing(for: viewModel.matrix) * 3)) {
                ForEach(0..<viewModel.matrix[row].count, id: \.self) { col in
                    if row == 0 {
                        self.selectableCircle(col: col, row: row, orientation: "top")
                    }
                }
            }
        }
    }
    
    func rectAndButtons() -> some View {
        return ForEach(0..<viewModel.matrix.count, id: \.self) { row in
            HStack(spacing: interSquareSpacing(for: viewModel.matrix)) {
                ForEach(0..<viewModel.matrix[row].count, id: \.self) { col in
                    if col == 0 {
                        self.selectableCircle(col: col, row: row, orientation:"left").padding(10)
                    }
                    let value = viewModel.matrix[row][col]
                    squareView(value: value, col: col, row: row)
                        .font(.system(size: fontSize(for: viewModel.matrix)))
                        .frame(width: squareSize(for: viewModel.matrix), height: squareSize(for: viewModel.matrix))
                        .rotationEffect(viewModel.gameSolved ? .degrees(360) : .degrees(0)) // Rotate if solved
                        .border(Color.black) // Optional: Add border around the square
                        .background(
                            ((viewModel.selectedCols.contains(col) || viewModel.selectedRows.contains(row)) ||
                             (viewModel.gameSolved && (viewModel.matrix[row][col] == 1)))
                                ? Color.yellow : Color.white
                        )
                        .padding(interSquareSpacing(for: viewModel.matrix)) // Optional: Padding inside the square */
                        
                    if col == viewModel.matrix.count - 1 {
                        self.selectableCircle(col: col, row: row, orientation:"right").padding(10)
                    }
                }
            }
        }
    }

    func squareView(value: Int, col: Int, row: Int) -> some View {
        let isSolved = value == 1 && viewModel.gameSolved // Check if the square is solved
        viewModel.stopTimer()
        
        return Text("\(value)")
            .frame(width: 50, height: 50)
            .rotationEffect(isSolved ? .degrees(360) : .degrees(0)) // Rotate if solved
            .animation(isSolved ? .easeInOut(duration: 2).repeatForever() : .default)
    }

    
    func saveScaling() -> some View {
        return HStack {
            Button(action: {
                self.viewModel.scaleRow(value: selectedNumber)
            }) {
                Text("Apply")
                    .padding(7)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Button(action: {
                self.viewModel.removeAllSelected()
            }) {
                Text("Close")
                    .padding(7)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
            }
        }
        .padding(2)
    }
    
    // fu
    
    @ViewBuilder
    func numberSlider() -> some View {
        switch (self.viewModel.selectedRows.count, self.viewModel.scaleType) {
        case (1, "divide") where self.viewModel.devideByArray.count >= 1:
            makeScalingView(title: "Devide Row by: \(selectedNumber)", array: self.viewModel.devideByArray)
        case (1, "multiply"):
            makeScalingView(title: "Multiply Row by: \(selectedNumber)", array: self.viewModel.multiplyByArray)
        case (1, "divide"):
            makeInfoView(message: "Row has no common divider")
        case (let count, _) where count > 1:
            makeInfoView(message: "Too many rows selected!")
        default:
            makeInfoView(message: "Select a row for Scaling")
        }
    }
    
    @ViewBuilder
    func makeScalingView(title: String, array: [Int]) -> some View {
        VStack {
            Text(title)
                .padding(2)
            Picker("Scale", selection: $selectedNumber) {
                ForEach(array, id: \.self) { value in
                    Text("\(value)").tag(value)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .onChange(of: selectedNumber) { newNumber in
                selectedNumber = newNumber
            }
            
        }
        saveScaling()
        
    }
    
    @ViewBuilder
    func makeInfoView(message: String) -> some View {
        HStack {
            Spacer()
            Text(message)
                .padding(5)
            Spacer()
        }
    }
    
    // function that enables switching between multiply and divide mode
    func switchModes() -> some View {
        return VStack {
            if self.viewModel.selectedRows.count == 1 {
                Picker(selection: $selectedOption, label: Text("")) {
                    Text("Multiply").tag(0)
                    Text("Divide").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedOption) { _ in
                    if selectedOption == 0 {
                        selectedNumber = self.viewModel.multiplyByArray[0]
                        self.viewModel.setScaleType(currentType: "multiply")
                        
                    } else if selectedOption == 1 {
                        if self.viewModel.devideByArray.count > 0 { selectedNumber = self.viewModel.devideByArray[0]}
                        self.viewModel.setScaleType(currentType: "divide")
                    }
                    //print(self.viewModel.scaleType)
                }
            }
        }
    }
    
    func buttonRowMenue() -> some View {
        return HStack {
            
            Spacer()
            if self.viewModel.selectedCols.count == 2 || self.viewModel.selectedRows.count == 2 {
                VStack {
                    Text("Multi Row Aktions").padding(2).fontWeight(.bold)
                    HStack{
                        Spacer()
                        Button(action: {
                            withAnimation {
                                viewModel.swapSelected()
                            }
                        }) {
                            VStack {
                                if viewModel.selectedCols.count == 2 {
                                    Image(systemName: "rectangle.2.swap")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    Text("Swap Cols")
                                        .foregroundColor(.blue)
                                } else if viewModel.selectedRows.count == 2 {
                                    Image(systemName: "rectangle.2.swap")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    Text("Swap")
                                        .foregroundColor(.blue)
                                } else if viewModel.selectedRows.count != 2 {
                                    Image(systemName: "rectangle.2.swap")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                    Text("Swap")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        if viewModel.selectedRows.count == 2{
                            Spacer()
                            Button(action: {
                                viewModel.addRows()
                            }) {
                                VStack {
                                    
                                    Image(systemName: "plus.app")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    Text("Add")
                                        .foregroundColor(.blue)
                                }
                                
                            }
                            Spacer()
                            Button(action: {
                                viewModel.subRows()
                            }) {
                                VStack {
                                    
                                    
                                    Image(systemName: "minus.square")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    Text("Sub")
                                        .foregroundColor(.blue)
                                    
                                }
                                
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
            } else {
                makeInfoView(message: "Select more for Muli Row Aktions")
            }
        }
    }
    
    
    
    
    func navigationButtons() -> some View {
        return Button(action: {
            print("Home")
        }) {
            VStack {
                Image(systemName: "house.fill")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
            
        }
    }
    // Game Screen
    var body: some View {
        //HomeScreenView()
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [topColor, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    
                    
                    VStack{
                        //Text("Gaussy Game").font(.title)
                        VStack{
                            if viewModel.gameSolved{
                                Text("You Finished the Game!").bold().font(.title)
                                Text("\(self.viewModel.numberOfMoves) moves and in \(viewModel.timeFormated)").bold().font(.title)
                                    .onAppear {
                                        viewModel.stopTimer()
                                    }
                            } else {
                                Text("Moves: \(self.viewModel.numberOfMoves)")
                                Text("Time: \(viewModel.timeFormated)")
                                    .onAppear {
                                        viewModel.timerCode()
                                        
                                    }
                            }
                        }
                    }
                    
                    HStack {
                        VStack(spacing: interSquareSpacing(for: viewModel.matrix)) {
                            buttonsTop()
                            rectAndButtons()
                        }
                        
                    }
                    
                }
                if !viewModel.gameSolved{
                    VStack{
                        
                        VStack{
                            switchModes()
                            numberSlider()
                        }.padding(4)
                            .background(Color.gray.opacity(0.2)) // Set the background color for the VStack
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2) // Set the frame around the VStack
                            )
                            .padding(4) // Adjust the padding around the frame
                        
                        withAnimation{
                            VStack{
                                buttonRowMenue()
                            }.padding(4)
                                .background(Color.gray.opacity(0.2)) // Set the background color for the VStack
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 2) // Set the frame around the VStack
                                )
                                .padding(4) // Adjust the padding around the frame
                            
                        }
                    }
                } else {
                    
                    Button(action: {
                        if !self.viewModel.gameSaved {
                            self.viewModel.saveGame() //saves the game
                            self.viewModel.gameSaved.toggle() // Toggles between true and false
                        } else {
                            print("Already Saved, cannot save again")
                        }
                    }) {
                        Text(self.viewModel.gameSaved ? "Already Saved Score" : "Save Score")
                            .padding(7)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                Spacer()
                
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
    func colorForDifficulty(_ difficulty: String) -> Color {
        switch difficulty {
        case "easy":
            return Color.green
        case "normal":
            return Color.blue
        case "hard":
            return Color.red
        default:
            return Color.gray
        }}
}
