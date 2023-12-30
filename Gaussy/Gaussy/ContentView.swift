// ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        //HomeScreenView()
        //GameContentView(viewModel: self.viewModel)
        NavigationView {
                    VStack {
                        NavigationLink(destination: GameContentView(viewModel: self.viewModel)) {
                            Text("See High Score List")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    //.navigationBarTitle("Gaussy Game").font(.title)
                    .navigationBarTitleDisplayMode(.inline) // Titel-Display-Modus auf .inline setzen
                }
        
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
