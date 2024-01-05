//
//  ViewModel.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 18.12.23.
//
// ViewModel.swift

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model: Model
    @State private var timer: Timer?
    //@State var backgroundColor: Color = .white
    

    init() {
        self.model = Model(size: 6, difficulty: .easy, username: "Peter")
    }
    
    func createNewGame(size: Int, difficulty: Difficulty, username: String){
        self.model = Model(size: size, difficulty: difficulty, username: username)
        //setGameRunning(true)

        
        
    }
    
    func appendToPlist(data: PlayerStats, user: String , time: Double, moves: Int ){
        let newDataToAdd2 = PlayerStats(username: user, time: time, moves: moves)
        
        do {
            try model.appendToPlist(data: newDataToAdd2, filename: model.plistName)
            
            // Successfully wrote data to the plist
        } catch {
            print("Error writing to plist: \(error)")
            // Handle the error here, such as showing an alert to the user or performing another action
        }
    }
    
    func readHighScoresFromPlist() -> {
        do {
            if let highScores: [PlayerStats] = try model.readFromPlist(filename: "HighScores", type: [PlayerStats].self) {
                // Successfully read data from the plist
                print("High Scores: \(highScores)")
                //highScores.append(PlayerStats)
            } else {
                print("No data found or unable to decode")
            }
        } catch {
            print("Error reading from plist: \(error)")
            // Handle the error here, such as showing an alert to the user or performing another action
        }
    }
    
    
    //func createNewGame
    
    var matrix: [[Int]] {
        model.matrix
    }
    
    var selectedRows: [Int] {
        model.selectedRows
    }
    
    var selectedCols: [Int] {
        model.selectedCols
    }
    
    var devideByArray: [Int] {
        model.devideByArray
    }
    
    var multiplyByArray: [Int] {
        model.multiplyByArray
    }
    
    var scaleType: String {
        model.scaleType
    }
    
    var numberOfMoves: Int{
        model.numberOfMoves
    }
    
    var difficultyLevels: [Difficulty] {
        model.difficultyLevels
    }
    
    
    
    var maxCharacterCount: Int {
        model.maxCharacterCount
    }
    
    var getPossibleSizes: [Int]{
        model.possibleSizes
    }
    
    var gameRunning: Bool{
        model.gameRunning
    }
    
    var time: Double {
        model.time
    }
    
    var timeFormated: String {
        model.timeFormated
    }

    
    
    
    
    
    func updateTimer(){
        model.timeTracking()
        //print(model.time)
    }
    
    func setSize(newSize: Int) {
        model.setSize(newSize: newSize)
    }
    
    func setGameRunning(_ value: Bool){
        model.gameRunning = value
    }
    
    func addRemoveFromSelected(col: Int, row: Int, orientation: String) {
        model.addRemoveFromSelected(col: col, row: row, orientation: orientation)
    }
    
    func swapSelected() {
        model.swapSelected()
    }
    
    func addRows() {
        model.addRows()
    }
    func subRows() {
        model.subRows()
    }
    
    func getDivider() {
        model.getDivider()
    }
    
    func setScaleType(currentType: String) {
        model.scaleType = currentType
    }
    
    func removeAllSelected(){
        model.removeAllSelected()
    }
    
    func scaleRow(value: Int){
        model.scaleRow(value: value)
    }
    
    func setDifficulty(newDifficulty: Difficulty){
        model.gameDifficulty = newDifficulty
    }

}
