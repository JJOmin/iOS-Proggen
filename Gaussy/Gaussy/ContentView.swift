// ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
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
                    ForEach(0..<viewModel.matrix.count, id: \.self) { row in
                        HStack(spacing: interSquareSpacing(for: viewModel.matrix)) {
                            Circle()
                                .fill(viewModel.selectedRow == row ? Color.blue : Color.gray)
                                .frame(width: 20, height: 20)
                                .onTapGesture {
                                    viewModel.selectedRow = row // Set the selected row in the ViewModel
                                }
                            
                            ForEach(0..<viewModel.matrix[row].count, id: \.self) { col in
                                Text("\(viewModel.matrix[row][col])")
                                    .font(.system(size: fontSize(for: viewModel.matrix)))
                                    .frame(width: squareSize(for: viewModel.matrix), height: squareSize(for: viewModel.matrix))
                                    .border(Color.black) // Optional: Rahmen um das Quadrat hinzufügen
                                    .padding(interSquareSpacing(for: viewModel.matrix)) // Optional: Innenabstand des Quadrats
                            }
                        }
                    }
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
