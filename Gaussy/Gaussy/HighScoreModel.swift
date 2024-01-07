//
//  HighScoreModel.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 04.01.24.
//

import Foundation

struct HighScoreModel {
    let plistFile: String = "HighScores"
    var highScores: [PlayerStats]? // Change to an array of PlayerStats
    var plistURL = URL(fileURLWithPath: "") // Empty URL
    
    var highScoresTimeSorted: [PlayerStats] = []
    var highScoresMovesSorted: [PlayerStats] = []
    
    var counterMoves: Int = 0 // var for the number displayed for the Rank in top list
    var counterTime: Int = 0 // var for the number displayed for the Rank in top list
    
    func writeToPlist<T: Encodable>(data: T, fileName: String) throws {
        let encoder = PropertyListEncoder()
        let encodedData = try encoder.encode(data)
        try encodedData.write(to: stringToUrl(fileName))
    }
    
    mutating func readFromPlist<T: Decodable>(type: T.Type, fileName: String) throws -> T? {
        let decoder = PropertyListDecoder()
        let data = try Data(contentsOf: stringToUrl(fileName))
        let decodedData = try decoder.decode(type, from: data)
        return decodedData
    }
    
    mutating func appendToPlist<T: Codable>(data: T, fileName: String) throws {
        var existingData = try readFromPlist(type: [PlayerStats].self, fileName: fileName) ?? []
        
        if let newData = data as? [PlayerStats] {
            existingData.append(contentsOf: newData)
        } else if let singleData = data as? PlayerStats {
            existingData.append(singleData)
        } else {
            throw NSError(domain: "InvalidDataType", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data type"])
        }
        
        try writeToPlist(data: existingData, fileName: fileName)
    }
    
    // function to convert a string into a url
    func stringToUrl(_ filename: String) -> URL {
        do {
            let plistURL = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appendingPathComponent(filename).appendingPathExtension("plist")
            return plistURL
        } catch {
            print("Error getting URL for file: \(error.localizedDescription)")
            return URL(fileURLWithPath: "") // Empty URL
        }
    }
    
    func getHighScore() -> [PlayerStats] {
            return highScores ?? [] // Return highScores if it exists, otherwise return an empty array
        }
    
    func sortScores() -> (sortedByTime: [PlayerStats], sortedByMoves: [PlayerStats]) {
            guard let highScores = highScores else { return ([], []) } // Return empty arrays if highScores is nil
            // Sort by time (ascending)
            let sortedByTime = highScores.sorted { $0.time < $1.time }
            // Sort by moves (ascending)
            let sortedByMoves = highScores.sorted { $0.moves < $1.moves }
            return (sortedByTime, sortedByMoves)
        }

}
