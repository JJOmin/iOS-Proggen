//
//  SetGameApp.swift
//  SetGame
//
//  Created by Leonhard Tilly on 23.10.23.
//

import SwiftUI

@main
struct SetGameApp: App {
    let set = ViewModel() //Pointer
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: set)
        }
    }
}
