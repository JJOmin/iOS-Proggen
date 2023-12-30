//
//  HomeScreen.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 30.12.23.
//

import Foundation

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("Gaussy Game")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 50)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            // Action for starting a new game
                            // Replace this with your logic
                            print("Start a new game")
                        }) {
                            Text("Start a New Game")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Button(action: {
                            // Action for viewing high score list
                            // Replace this with your logic
                            print("See High Score List")
                        }) {
                            Text("See High Score List")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Button(action: {
                            // Action for quitting the app
                            // Replace this with your logic
                            print("Quit the app")
                        }) {
                            Text("Quit")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
    }
}
