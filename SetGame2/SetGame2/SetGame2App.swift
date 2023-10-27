//
//  SetGame2App.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 27.10.23.
//

import SwiftUI

@main
struct SetGame2App: App {
    let setGame = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: setGame)
        }
    }
}
