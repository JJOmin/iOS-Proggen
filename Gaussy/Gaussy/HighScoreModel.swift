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
    var plistURL: URL = URL(fileURLWithPath: "") // Empty URL
    
    func writeToPlist<T: Encodable>(data: T, fileName: String) throws {
        let encoder = PropertyListEncoder()
        let encodedData = try encoder.encode(data)
        try encodedData.write(to: stringToUrl(fileName))
    }
    
    func readFromPlist<T: Decodable>(type: T.Type, fileName: String) throws -> T? {
        let decoder = PropertyListDecoder()
        let data = try Data(contentsOf: stringToUrl(fileName))
        let decodedData = try decoder.decode(type, from: data)
        return decodedData
    }
    
    func appendToPlist<T: Codable>(data: T, fileName: String) throws {
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
    
    //function to convert a string into a url
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

}




