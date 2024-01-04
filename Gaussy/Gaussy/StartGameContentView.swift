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
    @State var difficultyLevel: Difficulty = .easy // Initial value for difficulty
    @State var playerName: String = "JohnDoe" // Initial value for difficulty
    @State var size: Int = 2
    let maxCharacterCount = 21
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var backButtonOpacity: Double = 0.0 // Initial opacity for animation
    @State private var showHighScoreView = false // State variable to control HighScoreView presentation
    
    @State private var topColor: Color = .green // Default color
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [topColor, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .onChange(of: difficultyLevel) { newValue in
                      withAnimation {
                          topColor = colorForDifficulty(newValue)
                          
                      }
                    }
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
                            Text("\(value.rawValue)").tag(value)
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
                    
                    Text("Set your Username")
                        .font(.title)
                        .foregroundColor(.black)
                    HStack{
                        Spacer()
                        TextField("Enter your name", text: $playerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of: playerName) { newValue, _ in
                                playerName = newValue.filter { $0.isLetter }
                            }
                    }
                    Text("You entered: \(playerName)")
                        .foregroundColor(.black) // Just for demonstration to show the entered name
                        .padding()
                    Spacer()
                    
                    NavigationLink(destination: GameContentView(viewModel: self.viewModel)) {
                        Text("Start a New Game")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        
                        //self.viewModel.startTimer()
                        
                        self.viewModel.createNewGame(size: size, difficulty: difficultyLevel, username: playerName)
                      
                    })
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                //self.viewModel.stopTimer()
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            Image(systemName: "house")
                .foregroundColor(.black) // Change the color here
                .font(.title)
        }
            .opacity(backButtonOpacity),
                            trailing:
                                NavigationLink(destination: HighScoreView(viewModel: self.viewModel), isActive: $showHighScoreView) {
            Button(action: {
                // Navigate to HighScoreView
                //self.viewModel.stopTimer()
                self.showHighScoreView = true
            }) {
                Image(systemName: "list.number")
                    .foregroundColor(.black)
                    .font(.title)
            }
            .opacity(backButtonOpacity)
        }
        )
        .onAppear {
            withAnimation(.snappy(duration: 0.7)) {
                backButtonOpacity = 1.0 // Set opacity to 1 on view appear
            }
            
        }
        
    }
    func colorForDifficulty(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return Color.green
        case .normal:
            return Color.blue
        case .hard:
            return Color.red
        default:
            return Color.gray
        }}
}
