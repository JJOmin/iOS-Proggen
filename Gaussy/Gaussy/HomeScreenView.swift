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
                backgroundGradient
                VStack {
                    gameTitle
                    Spacer()
                    newGameButton
                    quitButton
                    Spacer()
                }
            }
        }
    }
    
    var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
    
    var gameTitle: some View {
        Text("Gaussy Game")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 50)
            .foregroundColor(.black)
    }
    
    var newGameButton: some View {
        NavigationLink(destination: StartGameContentView(viewModel: self.viewModel)) {
            Text("Start a New Game")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .simultaneousGesture(TapGesture().onEnded {
            self.viewModel.setGameRunning(false)
        })
        .padding()
    }
    
    var quitButton: some View {
        Button {
            // Action for quitting the app
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            }
        }label: {
            Text("Quit")
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
        }
    }
}
