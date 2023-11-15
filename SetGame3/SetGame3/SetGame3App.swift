//
//  SetGame3App.swift
//  SetGame3
//
//  Created by Leonhard Tilly on 15.11.23.
//
//


import SwiftUI

@main
struct SetGame3App: App {
    let setGame = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: setGame)
        }
    }
}
