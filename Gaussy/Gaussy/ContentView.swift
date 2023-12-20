// ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var selectedRow: Int = -1
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Gaussy Game").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
            }
            HStack {
                VStack(spacing: interSquareSpacing(for: viewModel.matrix)) {
                    MatrixView(matrix: viewModel.matrix, selectedRows: viewModel.selectedRows, selectedCols: viewModel.selectedCols)
                }
            }
            Spacer()
            
        }
    }
}
struct ClickableCircle: View {
    var matrix: [[Int]]
    var row: Int
    var col: Int
    let selectedRows: [Int]
    let selectedCols: [Int]
    var body: some View {
        if row == 0 && col != 0 {
            VStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)
                .onTapGesture {
                    print("Function to toggle the selection")
                }
                Text("\(matrix[row][col])")
                    .font(.system(size: fontSize(for: matrix)))
                    .frame(width: squareSize(for: matrix), height: squareSize(for: matrix))
                    .border(Color.black) // Optional: Add border around the square
                    .padding(interSquareSpacing(for: matrix)) // Optional: Padding inside the square
            }
        } else if col == 0 && row != 0 {
            HStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)
                .onTapGesture {
                    print("Function to toggle the selection")
                }
                Text("\(matrix[row][col])")
                    .font(.system(size: fontSize(for: matrix)))
                    .frame(width: squareSize(for: matrix), height: squareSize(for: matrix))
                    .border(Color.black) // Optional: Add border around the square
                    .padding(interSquareSpacing(for: matrix)) // Optional: Padding inside the square
            }
            
        } else if col == 0 && row == 0 {
            HStack {
                // Spacer() // Center horizontally
                Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        print("Function to toggle the selection")
                    }
                // Spacer() // Center horizontally
            }

            VStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        print("Function to toggle the selection")
                    }
                // Spacer() // Center vertically
                Text("\(matrix[row][col])")
                    .font(.system(size: fontSize(for: matrix)))
                    .frame(width: squareSize(for: matrix), height: squareSize(for: matrix))
                    .border(Color.black) // Optional: Add border around the square
                    .padding(interSquareSpacing(for: matrix)) // Optional: Padding inside the square
            }
            
        } else {
            Text("\(matrix[row][col])")
                .font(.system(size: fontSize(for: matrix)))
                .frame(width: squareSize(for: matrix), height: squareSize(for: matrix))
                .border(Color.black) // Optional: Add border around the square
                .padding(interSquareSpacing(for: matrix)) // Optional: Padding inside the square
            
        }
    }
}
struct MatrixView: View {
    let matrix: [[Int]] // Assuming your matrix is of type [[Int]]
    let selectedRows: [Int]
    let selectedCols: [Int]
    @State var selectedRow: Int = -1
    
    var body: some View {
        ForEach(0..<matrix.count, id: \.self) { row in
            HStack(spacing: (squareSize(for: matrix) - 20 + interSquareSpacing(for: matrix) * 3)) {
                ForEach(0..<matrix[row].count, id: \.self) { _ in
                    if row == 0 {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                print("Function to toggle the selection")
                            }
                    }
                }
            }
        }
        
        ForEach(0..<matrix.count, id: \.self) { row in
            HStack(spacing: interSquareSpacing(for: matrix)) {
                ForEach(0..<matrix[row].count, id: \.self) { col in
                    // ClickableCircle(matrix: matrix, row: row, col:col, selectedRows: selectedRows, selectedCols: selectedCols)
                    
                    Text("\(matrix[row][col])")
                        .font(.system(size: fontSize(for: matrix)))
                        .frame(width: squareSize(for: matrix), height: squareSize(for: matrix))
                        .border(Color.black) // Optional: Add border around the square
                        .padding(interSquareSpacing(for: matrix)) // Optional: Padding inside the square */
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
