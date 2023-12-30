import SwiftUI

struct HighScoreView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.highScores, id: \.id) { score in
                Text("\(score.playerName): \(score.score)")
            }
            .navigationBarTitle("High Scores")
        }
    }
}
