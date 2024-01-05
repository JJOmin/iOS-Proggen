import SwiftUI

struct HighScoreView: View {
    //let playerStatsArray: [PlayerStats] // Pass your array of PlayerStats here
    
    let sordedScores: [[PlayerStats]]
    
        
    var body: some View {
        NavigationView {
            VStack {
                Text("High Score Lists")
                    .font(.title)
                    .padding(.top, 20)
                
                HStack(spacing: 30) {
                    NavigationView {
                        List(sordedScores[0]) { playerStat in
                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(playerStat.username)")
                                    .font(.headline)
                                Text("Moves: \(playerStat.moves)")
                            }
                        }
                        .navigationBarTitle("Moves")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .listStyle(PlainListStyle())
                    
                    NavigationView {
                        List(sordedScores[1]) { playerStat in
                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(playerStat.username)")
                                    .font(.headline)
                                Text("Time: \(playerStat.time)")
                            }
                        }
                        .navigationBarTitle("Time")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .listStyle(PlainListStyle())
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}

