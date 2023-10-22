//
//  MemoryGameLectureApp.swift
//  MemoryGameLecture
//
//  Created by Leonhard Tilly on 20.10.23.
//

import SwiftUI

@main
struct MemoryGameLectureApp: App {
    let game = ViewModel() //Pointer
    
    var body: some Scene {
        WindowGroup {
            ContentView(accViewModel: game)
        }
    }
}
