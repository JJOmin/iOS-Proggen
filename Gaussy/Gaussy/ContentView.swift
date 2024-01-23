// ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
            HomeScreenView(viewModel: self.viewModel)
            // HighScoreView(viewModel: self.viewModel, sScore: [[userName: "John Doe", time: 1000, moves: 44]])
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel() // Initializing ViewModel with a size of 4x4
        ContentView(viewModel: viewModel)
    }
}
