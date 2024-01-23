import SwiftUI

struct HighScoreView: View {
    @ObservedObject var viewModel: ViewModel
    let sScore: [[PlayerStats]] // sortedScores

    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("High Score Lists")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)

                // Scores Lists
                HStack(spacing: 30) {
                    ScoreListView(title: "Moves", scores: sScore[0], isTimeList: false, viewModel: viewModel)
                    ScoreListView(title: "Time", scores: sScore[1], isTimeList: true, viewModel: viewModel)
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}

struct ScoreListView: View {
    let title: String
    let scores: [PlayerStats]
    let isTimeList: Bool
    let viewModel: ViewModel

    var body: some View {
        VStack {
            Text(title)
                .font(.title)

            List {
                ForEach(0..<scores.count, id: \.self) { index in
                    ScoreRowView(score: scores[index], index: index, isTimeList: isTimeList, viewModel: viewModel)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .listStyle(PlainListStyle())
        }
    }
}

struct ScoreRowView: View {
    let score: PlayerStats
    let index: Int
    let isTimeList: Bool
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(index + 1). \(score.username)\(score.username == viewModel.userName ? " (You)" : "")")
                .font(.headline)
                .foregroundColor(score.username == viewModel.userName ? Color.yellow : Color.primary)

            if isTimeList {
                if let formattedTime = viewModel.formatSecondsToString(timeToFormat: score.time) {
                    Text("\(formattedTime)")
                        .foregroundColor(score.username == viewModel.userName ? Color.yellow : Color.primary)
                }
            } else {
                Text("\(score.moves) moves")
                    .foregroundColor(score.username == viewModel.userName ? Color.yellow : Color.primary)
            }
        }
    }
}
