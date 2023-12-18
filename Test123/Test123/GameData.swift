import Foundation

class GameData: ObservableObject {
    @Published var numbers: [[Int]] = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ]
    
    @Published var selectedRows: [Bool] = [false, false, false]
}

