//
//  HomeScreen.swift
//  Gaussy
//
//  Created by Leonhard Tilly on 30.12.23.
//

import Foundation

import SwiftUI
struct HomeScreenView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
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
                    
                    NavigationLink(destination: StartGameContentView(viewModel: self.viewModel)) {
                        Text("Start a New Game")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }.simultaneousGesture(TapGesture().onEnded {
                        self.viewModel.setGameRunning(false)
                        /*let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            print("Timer fired!")
                        }*/
                    })
                    .padding()
                    
                    /*
                        NavigationLink(destination: StartGameContentView(viewModel: self.viewModel)) {
                            Text("Continue Game comming Soon")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.yellow)
                                .cornerRadius(10)
                        }.simultaneousGesture(TapGesture().onEnded {
                            print(self.viewModel.gameRunning)
                        })
                        .padding()
                    
                    
                    */
                    NavigationLink(destination: HighScoreView(viewModel: self.viewModel, sordedScores: viewModel.sortedScores)) {
                        Text("See High Score List")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        // Action for quitting the app
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
                        }
                    }) {
                        Text("Quit")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
            //.navigationBarTitle(displayMode: .inline)
        }
    }
}
