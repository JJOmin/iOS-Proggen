// ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    func selectableCircle(col: Int, row: Int, orientation: String) -> some View {
            return Circle()
                .fill(Color.gray)
                .frame(width: 20, height: 20)
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
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel() // Initializing ViewModel with a size of 4x4
        ContentView(viewModel: viewModel)
    }
}
