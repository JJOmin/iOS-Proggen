//
//  HighScoreModel.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 04.01.24.
//

import Foundation

struct HighScoreModel {
    static func writeToPlist<T: Encodable>(data: T, filename: String) throws {
        let encoder = PropertyListEncoder()
        let plistURL = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent(filename).appendingPathExtension("plist")
        
        let encodedData = try encoder.encode(data)
        try encodedData.write(to: plistURL)
    }
    
    static func readFromPlist<T: Decodable>(filename: String, type: T.Type) throws -> T? {
        let decoder = PropertyListDecoder()
        let plistURL = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent(filename).appendingPathExtension("plist")
        
        let data = try Data(contentsOf: plistURL)
        let decodedData = try decoder.decode(type, from: data)
        return decodedData
    }
    
    // You may need to modify this method based on how you structure your data
    static func appendToPlist<T: Codable>(data: T, filename: String) throws {
        var existingData = try readFromPlist(filename: filename, type: [T].self) ?? []
        existingData.append(data)
        try writeToPlist(data: existingData, filename: filename)
    }
}
