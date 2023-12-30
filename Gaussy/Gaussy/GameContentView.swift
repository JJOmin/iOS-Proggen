// ContentView.swift

import SwiftUI

struct GameContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedNumber = 1
    @State private var selectedOption = 0
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
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
    }
    
    func buttonsTop() -> some View {
        return ForEach(0..<viewModel.matrix.count, id: \.self) { row in
            HStack(spacing: (squareSize(for: viewModel.matrix) - 20 + interSquareSpacing(for: viewModel.matrix) * 3)) {
                ForEach(0..<viewModel.matrix[row].count, id: \.self) { col in
                    if row == 0 {
                        self.selectableCircle(col: col, row: row, orientation:"top")
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
                    Text("\(viewModel.matrix[row][col])")
                        .font(.system(size: fontSize(for: viewModel.matrix)))
                        .frame(width: squareSize(for: viewModel.matrix), height: squareSize(for: viewModel.matrix))
                        .border(Color.black) // Optional: Add border around the square
                        .background((viewModel.selectedCols.contains(col) || viewModel.selectedRows.contains(row)) ? Color.yellow : Color.white)
                        .padding(interSquareSpacing(for: viewModel.matrix)) // Optional: Padding inside the square */
                    if col == viewModel.matrix.count - 1 {
                        self.selectableCircle(col: col, row: row, orientation:"right").padding(10)
                        
                    }
                    
                }
            }
        }
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
            makeScalingView(title: "Devide Row by: \(selectedNumber)",
                            array: self.viewModel.devideByArray)
        case (1, "multiply"):
            makeScalingView(title: "Multiply Row by: \(selectedNumber)",
                            array: self.viewModel.multiplyByArray)
        case (1, "divide"):
            makeInfoView(message: "Row has no common divider")
        case (let count, _) where count > 1:
            makeInfoView(message: "Too many rows selected!")
        default:
            makeInfoView(message: "Select a row to scale")
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
            if self.viewModel.selectedCols.count == 1 || self.viewModel.selectedRows.count == 1 {
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
                Spacer()
                Button(action: {
                    viewModel.addRows()
                }) {
                    VStack {
                        if viewModel.selectedRows.count == 2 {
                            Image(systemName: "plus.app")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Add")
                                .foregroundColor(.blue)
                        } else if viewModel.selectedCols.count != 2 {
                            Image(systemName: "plus.app")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("Add")
                                .foregroundColor(.gray)
                        }
                    }
                }
                Spacer()
                Button(action: {
                    viewModel.subRows()
                }) {
                    VStack {
                        if viewModel.selectedRows.count == 2 {
                            Image(systemName: "minus.square")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Sub")
                                .foregroundColor(.blue)
                        } else if viewModel.selectedCols.count != 2 {
                            Image(systemName: "minus.square")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("Sub")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Spacer()
            } else {
                makeInfoView(message: "Select two rows/cols to Swap/Add/Sub ")
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
        VStack {
            VStack {
                HStack{
                    Spacer()
                    Button(action: {
                        print("Home")
                    }) {
                        Image(systemName: "house")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    VStack{
                        Text("Gaussy Game").font(.title)
                        Text("Moves: \(self.viewModel.numberOfMoves)")
                    }
                    Spacer()
                    Button(action: {
                        print("HighScore")
                    }) {
                        Image(systemName: "list.number")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                HStack {
                    VStack(spacing: interSquareSpacing(for: viewModel.matrix)) {
                        buttonsTop()
                        rectAndButtons()
                    }
                    
                }
                
            }
            
            VStack{
                
                VStack{
                    switchModes()
                    numberSlider()
                }.padding(5)
                    .background(Color.gray.opacity(0.2)) // Set the background color for the VStack
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 2) // Set the frame around the VStack
                    )
                    .padding(10) // Adjust the padding around the frame
                
                withAnimation{
                    VStack{
                        buttonRowMenue()
                    }.padding(5)
                        .background(Color.gray.opacity(0.2)) // Set the background color for the VStack
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2) // Set the frame around the VStack
                        )
                        .padding(10) // Adjust the padding around the frame
                    
                }
            }
            Spacer()
        }
    }
}/**
extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
*/
