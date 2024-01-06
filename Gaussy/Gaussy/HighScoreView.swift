import SwiftUI

struct HighScoreView: View {
    //let playerStatsArray: [PlayerStats] // Pass your array of PlayerStats here
    @ObservedObject var viewModel: ViewModel
    let sordedScores: [[PlayerStats]]

    
        
    var body: some View {
        NavigationView {
            VStack {
                Text("High Score Lists")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                
                HStack(spacing: 30) {
                    VStack{
                        Text("Moves").font(.title)
                        NavigationView {
                            List {
                                ForEach(0..<sordedScores[0].count, id: \.self) { index in
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("\(index + 1). \(sordedScores[0][index].username)")
                                            .font(.headline)
                                        Text("\(sordedScores[0][index].moves) moves")
                                    }
                                }
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .listStyle(PlainListStyle())
                        }
                    }
                    VStack{
                        Text("Time").font(.title)
                        NavigationView {
                            List {
                                ForEach(0..<sordedScores[1].count, id: \.self) { index in
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("\(index + 1). \(sordedScores[1][index].username)")
                                            .font(.headline)
                                        Text("\(viewModel.formatSecondsToString(timeToFormat: sordedScores[1][index].time))")
                                    }
                                }
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .listStyle(PlainListStyle())
                            
                        }
                    }
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}

