// ContentView.swift

import SwiftUI

struct ContentView: View {
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
                viewModel.addRemoveFromSelected(col: col, row: row, orientation: orientation)
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
                // Action for Save button
                // Put your save logic here
                print("Save button tapped")
            }) {
                Text("Save")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Button(action: {
                // Action for Cancel button
                // Put your cancel logic here
                print("Cancel button tapped")
            }) {
                Text("Cancel")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    // fu
    
    func numberSlider() -> some View {
        if self.viewModel.selectedRows.count == 1 && self.viewModel.scaleType == "devide" && self.viewModel.devideByArray.count == 1 {
            return VStack {
                Text("Devide Row by: \(selectedNumber)")
                    .padding(5)
                Picker("Scale", selection: $selectedNumber) {
                    ForEach(self.viewModel.devideByArray, id: \.self) { value in
                        Text("\(value)").tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: selectedNumber) { newNumber in
                    selectedNumber = newNumber
                }
                saveScaling()

            }
            .eraseToAnyView() // Use an extension method to erase the type
        } else {
            return VStack {
                Text("Select Row or Row only devidor is 1")
                    .padding(5)
            }
            .eraseToAnyView() // Use an extension method to erase the type
        }
    }
    
    // function that enables switching between multiply and divide mode
    func switchModes() -> some View {
        return VStack {
            Picker(selection: $selectedOption, label: Text("")) {
                Text("Multiply").tag(0)
                Text("Divide").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedOption) { _ in
                if selectedOption == 0 {
                    self.viewModel.setScaleType(currentType: "multiply")
                    
                } else if selectedOption == 1 {
                    self.viewModel.setScaleType(currentType: "devide")
                }
                print(self.viewModel.scaleType)
            }
        }
    }
    
    func buttonRowMenue() -> some View {
        return HStack {
            Button(action: {
                viewModel.swapSelected()
            }) {
                VStack {
                    if viewModel.selectedCols.count == 2 {
                        Image(systemName: "rectangle.2.swap")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                        Text("Swap Cols")
                            .foregroundColor(.yellow)
                    } else if viewModel.selectedRows.count == 2 {
                        Image(systemName: "rectangle.2.swap")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                        Text("Swap Rows")
                            .foregroundColor(.yellow)
                    } else if viewModel.selectedRows.count != 2 {
                        Image(systemName: "rectangle.2.swap")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("Swap")
                            .foregroundColor(.gray)
                    }
                }
            }
            Button(action: {
                viewModel.addRows()
            }) {
                VStack {
                    if viewModel.selectedRows.count == 2 {
                        Image(systemName: "plus.app")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                        Text("Add Cols")
                            .foregroundColor(.yellow)
                    } else if viewModel.selectedCols.count != 2 {
                        Image(systemName: "plus.app")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("Add Cols")
                            .foregroundColor(.gray)
                    }
                }
            }
            Button(action: {
                viewModel.subRows()
            }) {
                VStack {
                    if viewModel.selectedRows.count == 2 {
                        Image(systemName: "minus.square")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                        Text("Subtract Cols")
                            .foregroundColor(.yellow)
                    } else if viewModel.selectedCols.count != 2 {
                        Image(systemName: "minus.square")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("Subtract Cols")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Gaussy Game").font(.title)
            }
            VStack {
                HStack {
                    VStack(spacing: interSquareSpacing(for: viewModel.matrix)) {
                        buttonsTop()
                        rectAndButtons()
                    }
                    
                }
                switchModes()
            }
            
            numberSlider()
        
            Spacer()
            buttonRowMenue()
            
        }
    
        }
    }
extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel() // Initializing ViewModel with a size of 4x4
        ContentView(viewModel: viewModel)
    }
}
