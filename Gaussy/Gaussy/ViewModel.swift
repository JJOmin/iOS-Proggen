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
    @Published private var highScoreModel: HighScoreModel
    var timer: Timer?
    
    @State var backButtonOpacity: Double = 0.0 // Initial opacity for animation
    @State var showHighScoreView = false // State variable to control HighScoreView presentation
    //@State var backgroundColor: Color = .white
    var backbuttonList: Bool = true
    

    init() {
        self.model = Model(size: 6, difficulty: .unset, username: "Peter")
        self.highScoreModel = HighScoreModel()
        readHighScoresFromPlist()
        getSortedScors()
    }
    
    func createNewGame(size: Int, difficulty: Difficulty, username: String){
        self.model = Model(size: size, difficulty: difficulty, username: username)
        
        writeToPlist(userName: "Enis", time: 500, moves: 20)
        //appendToPlist(userName: "JohnDoe", time: 305, moves: 30)
        readHighScoresFromPlist()
        getSortedScors()
    }
    
    func appendToPlist(){
        let newScore = PlayerStats(id: UUID(), username: model.username, time: model.time, moves: model.numberOfMoves)
        
        do {
            try highScoreModel.appendToPlist(data: newScore, fileName: highScoreModel.plistFile)
            
            // Successfully wrote data to the plist
        } catch {
            print("Error writing to plist: \(error)")
            // Handle the error here, such as showing an alert to the user or performing another action
        }
    }
    
    func readHighScoresFromPlist(){
        do {
            if let highScores: [PlayerStats] = try highScoreModel.readFromPlist(type: [PlayerStats].self, fileName: highScoreModel.plistFile) {
                // Successfully read data from the plist
                highScoreModel.highScores = highScores
                //highScores.append(PlayerStats)
            } else {
                print("No data found or unable to decode")
            }
        } catch {
            print("Error reading from plist: \(error)")
            // Handle the error here, such as showing an alert to the user or performing another action
        }
    }
    
    func writeToPlist(userName: String , time: Double, moves: Int){
        let newScore = [PlayerStats(id: UUID(), username: userName, time: time, moves: moves)]
        
        do {
            try highScoreModel.writeToPlist(data: newScore, fileName: highScoreModel.plistFile)
            
            // Successfully wrote data to the plist
        } catch {
            print("Error writing to plist: \(error)")
            // Handle the error here, such as showing an alert to the user or performing another action
        }
    }
    
    func getSortedScors(){
        let (sortedByTime, sortedByMoves) = highScoreModel.sortScores()
        highScoreModel.highScoresTimeSorted = sortedByTime
        highScoreModel.highScoresMovesSorted = sortedByMoves
    }
    
    var sortedScores: [[PlayerStats]]{
        //getSortedScors()
        return [highScoreModel.highScoresTimeSorted, highScoreModel.highScoresMovesSorted]
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
    var highScores: [PlayerStats]{
        highScoreModel.getHighScore()
    }
    
    var gameSolved: Bool{
        model.gameSolved
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
    
    var difficulty: Difficulty{
        model.gameDifficulty
    }
    
    var size: Int{
        model.size
    }
    var userName: String{
        model.username
    }
    
    
    
    func getBackButton() -> Bool{
        if model.gameSolved{
            return false
        } else {
            return true
        }
    }
    
    func addCounterMoves() -> Int{
        highScoreModel.counterMoves += 1
        return highScoreModel.counterMoves
    }
    func addCounterTime() -> Int{
        highScoreModel.counterTime += 1
        return highScoreModel.counterTime
    }

    
    
    
    func formatSecondsToString(timeToFormat: Double) -> String{
        model.formatSecondsToString(timeToFormat: timeToFormat)
    }
    
    func updateTimer(){
        model.timeTracking()
    }
    
    func timerCode(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] _ in
                updateTimer()
        }
    }
    
    func stopTimer(){
        if gameRunning || gameSolved {
            timer?.invalidate()
        }
    }
    
    func setSize(newSize: Int) {
        model.setSize(newSize: newSize)
    }
    
    func setGameRunning(_ value: Bool){
        model.gameRunning = value
        print(value)
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
    
    func setUserName(_ userName: String) {
        model.username = userName
    }
    
    

}
