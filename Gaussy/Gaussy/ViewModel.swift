//
//  ViewModel.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

import Foundation
// ViewModel.swift

class ViewModel: ObservableObject {
    @Published var matrix: [[Int]] = []
    init() {
        self.matrix = Model.identityMatrix(size: 4)
    }
}
