import SwiftUI

struct HighScoreView: View {
    //let playerStatsArray: [PlayerStats] // Pass your array of PlayerStats here
    
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
                            List(sordedScores[0]) { playerStat in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(playerStat.username)")
                                        .font(.headline)
                                    Text("Moves: \(playerStat.moves)")
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .listStyle(PlainListStyle())
                    }
                    VStack{
                        Text("Time").font(.title)
                        NavigationView {
                            List(sordedScores[1]) { playerStat in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(playerStat.username)")
                                        .font(.headline)
                                    Text("Time: \(playerStat.time)")
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .listStyle(PlainListStyle())
                    }
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}

