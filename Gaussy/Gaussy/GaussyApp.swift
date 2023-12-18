//
//  GaussyApp.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//

import SwiftUI

@main
struct GaussyApp: App {
    let viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
