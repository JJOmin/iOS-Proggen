//
//  iOS_ProgrammierungApp.swift
//  iOS-Programmierung
//
//  Created by Leonhard Tilly on 28.09.23.
//

import SwiftUI

@main
struct iOS_ProgrammierungApp: App {
    let game = EmojiMemoryGame(model: <#MemoryGame<String>#>, currentThemeForModel: <#Theme<String>#>)
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
