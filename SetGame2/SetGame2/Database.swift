//
//  Database.swift
//  SetGame2
//
//  Created by Leonhard Tilly on 28.10.23.
//

import Foundation
import SwiftUI

internal struct Database{
    var reactingString = ["Du schaffst das", "Super, jetzt nurnoch 2 dazu passende", "Wow, jetzt nurnoch einer", "Schade, das passt doch nicht"]
    
    let colorMapping: [String: Color] = [
        "white": .white,
        "red": .red,
        "orange": .orange,
        "blue": .blue,
        "green": .green,
        "gray": .gray,
        "purple": .purple,
        "pink": .pink,
        "yellow": .yellow,
        "black": .black,
        "indigo": .indigo,
        "mint": .mint
    ]
}
