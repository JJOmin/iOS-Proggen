//
//  HighScoreModel.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 04.01.24.
//

import Foundation
/*

// High score entry for time
struct TimeHighScoreEntry: Codable {
    let username: String
    let time: TimeInterval
}

// High score entry for number of moves
struct MovesHighScoreEntry: Codable {
    let username: String
    let numberOfMoves: Int
}

// High score manager handling both lists
class HighScoreManager {
    var timeHighScores: [TimeHighScoreEntry]
    var movesHighScores: [MovesHighScoreEntry]
    
    // Initialize with empty lists or load from saved plist files
    init() {
        // Load existing high scores from plist files or initialize empty arrays
        // (code for loading plist files not shown in this example)
        timeHighScores = loadTimeHighScoresFromPlist() ?? []
        movesHighScores = loadMovesHighScoresFromPlist() ?? []
    }
    
    // Function to add a new time-based high score entry
    func addTimeHighScore(username: String, time: TimeInterval) {
        let newEntry = TimeHighScoreEntry(username: username, time: time)
        timeHighScores.append(newEntry)
        // Update plist file or save to storage (not shown in this example)
    }
    
    // Function to add a new moves-based high score entry
    func addMovesHighScore(username: String, moves: Int) {
        let newEntry = MovesHighScoreEntry(username: username, numberOfMoves: moves)
        movesHighScores.append(newEntry)
        // Update plist file or save to storage (not shown in this example)
    }
    
    // Function to retrieve top time-based high scores
    func getTopTimeHighScores(count: Int) -> [TimeHighScoreEntry] {
        return Array(timeHighScores.prefix(count))
    }
    
    // Function to retrieve top moves-based high scores
    func getTopMovesHighScores(count: Int) -> [MovesHighScoreEntry] {
        return Array(movesHighScores.prefix(count))
    }
    
    // Additional functions for saving/updating plist files not shown in this example
}
*/
