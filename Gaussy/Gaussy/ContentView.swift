// ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    let matrix: [[Int]]
    // let selectedRows: [Int]
    // let selectedCols: [Int]
    @State var selectedRow: Int = -1
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.matrix = viewModel.matrix
        // self.selectedRows = viewModel.selectedRows
        // self.selectedCols = viewModel.selectedCols
    }
    func selectableCircle(col: Int, row: Int, orientation: String) -> some View {
            return Circle()
                .fill(Color.gray)
                .frame(width: 20, height: 20)
                .onTapGesture {
                    viewModel.addRemoveFromSelected(col: col, row: row, orientation: orientation)
                    /*
                    print(orientation)
                    print(viewModel.selectedRows)
                    print(viewModel.selectedCols)*/
                }
        }
    
    func buttonsTop() -> some View {
        return ForEach(0..<matrix.count, id: \.self) { row in
            HStack(spacing: (squareSize(for: matrix) - 20 + interSquareSpacing(for: matrix) * 3)) {
                ForEach(0..<matrix[row].count, id: \.self) { col in
                    if row == 0 {
                        self.selectableCircle(col: col, row: row, orientation:"top")
                    }
                }
            }
        }
    }
    
    func rectAndButtons() -> some View {
        return ForEach(0..<matrix.count, id: \.self) { row in
            HStack(spacing: interSquareSpacing(for: matrix)) {
                ForEach(0..<matrix[row].count, id: \.self) { col in
                    if col == 0 {
                        self.selectableCircle(col: col, row: row, orientation:"left")
                    }
                    Text("\(matrix[row][col])")
                        .font(.system(size: fontSize(for: matrix)))
                        .frame(width: squareSize(for: matrix), height: squareSize(for: matrix))
                        .border(Color.black) // Optional: Add border around the square
                        .background((viewModel.selectedCols.contains(col) || viewModel.selectedRows.contains(row)) ? Color.yellow : Color.white)
                        .padding(interSquareSpacing(for: matrix)) // Optional: Padding inside the square */
                    if col == matrix.count - 1 {
                        self.selectableCircle(col: col, row: row, orientation:"right")
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
