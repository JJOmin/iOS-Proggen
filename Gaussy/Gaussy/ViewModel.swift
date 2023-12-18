//
//  ViewModel.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//
// ViewModel.swift

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var matrix: [[Int]] = []
    @Published var selectedRow: Int? // Property to store the selected row
    
    init() {
        self.matrix = Model.identityMatrix(size: 3)
    }
}
