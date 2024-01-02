//
//  StartGameContentView.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 02.01.24.
//

import Foundation

import SwiftUI

struct StartGameContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var difficultyLevel: String = "easy" // Initial value for difficulty
    @State var playerName: String = "JohnDoe" // Initial value for difficulty
    @State var size: Int = 2
    
    var topColor: Color {
            if difficultyLevel == "easy" {
                return Color.green
            } else if difficultyLevel == "normal" {
                return Color.blue
            } else if difficultyLevel == "hard" {
                return Color.red
            } else {
                // Handle other cases or set a default color
                return Color.gray
            }
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [topColor, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Before you can start...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                        .foregroundColor(.black)
                    
                    Spacer()
                    Text("Select Difficulty Level")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Picker("Difficulty Level: ", selection: $difficultyLevel) {
                        ForEach(self.viewModel.difficultyLevels, id: \.self) { value in
                            Text("\(value)").tag(value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: difficultyLevel) { newDifficulty, _ in
                        self.viewModel.setDifficulty(newDifficulty: newDifficulty) // Update the external variable
                    }
                    Spacer()
                    Text("Select Matrix Size")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Picker("SelecMatrix Size: ", selection: $size) {
                        ForEach(self.viewModel.getPossibleSizes, id: \.self) { value in
                            Text("\(value)").tag(value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: size) { newSize, _ in
                        self.viewModel.setSize(newSize: newSize) // Update the external variable
                    }
                    Spacer()
                    /*
                     Text("Set your Username")
                     .font(.title)
                     .foregroundColor(.black) */
                    HStack{
                        Spacer()
                        TextField("Enter your name", text: $playerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of: playerName) { newValue, _ in
                                if newValue.count > self.viewModel.maxCharacterCount {
                                    playerName = String(newValue.prefix(self.viewModel.maxCharacterCount))
                                }
                            }
                        Spacer()
                    }
                    
                    Text("You entered: \(playerName)")
                        .foregroundColor(.black) // Just for demonstration to show the entered name
                        .padding()
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                        //self.viewModel.scaleRow(value: selectedNumber)
                    }) {
                        Text("Start Game")
                            .padding(20)
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}
