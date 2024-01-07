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
    @Environment(
        \.presentationMode)
    var presentationMode: Binding<PresentationMode>
    @State private var navigationActive = false // Add a state variable
    @State private var backButtonOpacity: Double = 0.0 // Initial opacity for animation
    @State private var showHighScoreView = false // State variable to control HighScoreView presentation
    
    @State private var topColor: Color = .green // Default color
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [topColor, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .onChange(of: difficultyLevel) { newValue, _ in
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
                    // Select Difficulty Level
                    Spacer()
                    selectDifficulty()
                    // Select Matrix Size
                    Spacer()
                    selectMatrixSize()
                    Spacer()
                    // Set Username
                    selectUsername()
                    Spacer()
                    // Start Game Link
                    startGame()
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    withAnimation(.linear(duration: 0.7)) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image(systemName: "house")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .opacity(backButtonOpacity),
            
            trailing:
                HStack {
                    NavigationLink(
                        destination: HighScoreView(viewModel: viewModel, sScore: viewModel.sortedScores),
                        isActive: $navigationActive
                    ) {
                        EmptyView()
                    }
                    .hidden() // Hide the label

                    Button {
                        // Navigate to HighScoreView
                        self.navigationActive = true
                    } label: {
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
    
    func selectDifficulty() -> some View {
        return VStack {
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
        }
    }
    
    func selectMatrixSize() -> some View {
        return VStack { Text("Select Matrix Size")
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
                size = newSize // Update the external variable
            }
        }
    }
    
    func selectUsername() -> some View {
        return VStack {
            
            Text("Set your Username")
                .font(.title)
                .foregroundColor(.black)
            
            HStack {
                Spacer()
                TextField("Enter your name", text: $playerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: playerName) { newValue, _ in
                        playerName = (newValue.filter { $0.isLetter })
                    }
            }
            Text("You entered: \(playerName)")
                .foregroundColor(.black) // Just for demonstration to show the entered name
                .padding()
        }
    }
    func startGame() -> some View {
        return VStack {
            NavigationLink(destination: GameContentView(viewModel: self.viewModel)) {
                Text("Start a New Game")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .simultaneousGesture(TapGesture().onEnded {
                self.viewModel.setGameRunning(true)
                self.viewModel.createNewGame(size: size, difficulty: difficultyLevel, username: playerName)
            })
        }
    }
}
