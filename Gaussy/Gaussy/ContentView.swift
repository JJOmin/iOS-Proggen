// ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedNumber = 0
    // let allowedValues = [0, 1, 2, 3, 5, 4, 7, 91]
    
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
    
    // fu
    
    func numberSlider() -> some View {
        if self.viewModel.selectedRows.count == 1 {
            return VStack {
                Text("Scale Row by: \(selectedNumber)")
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
            }
        } else {
            return VStack {
                Text("Select one Row to Scale...greyed out Picker coming soon")
                    .padding(5)
            }
        }
    }

    var body: some View {
        VStack {
            VStack {
                Text("Gaussy Game").font(.title)
            }
            HStack {
                VStack(spacing: interSquareSpacing(for: viewModel.matrix)) {
                    buttonsTop()
                    rectAndButtons()
                    
                }
            }
            Spacer()
            numberSlider()
            Spacer()
            
            // Create a button
            HStack {
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
    
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel() // Initializing ViewModel with a size of 4x4
        ContentView(viewModel: viewModel)
    }
}
