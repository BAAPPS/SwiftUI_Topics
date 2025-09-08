//
//  ContentView.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/7/25.
//

import SwiftUI

struct ContentView: View {
    let gamesVM = GamesViewModel()
    let gameViewModeModel = GamesViewModeModel()
    
    /// ⚠️ Previously used state-based button navigation:
    /// `selectedGame` + `isPresented` binding approach allowed the chevron
    /// button to trigger navigation, but row itself became non-tappable.
    /// Currently using NavigationLink inside the row for simpler behavior.
    
    //    @State var selectedGame: GamesModel? = nil
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray800
                    .ignoresSafeArea()
                // GamesListGridView(selectedGame: $selectedGame)
                GamesListGridView()
                    .environment(gamesVM)
                    .environment(gameViewModeModel)
                    .navigationDestination(for: GamesModel.self) { game in
                        GamesDetailView(game: game)
                    }
                
                
//                    .navigationDestination(isPresented: Binding(
//                        get: { selectedGame != nil },
//                        set: { if !$0 { selectedGame = nil } }
//                    )) {
//                        if let game = selectedGame {
//                            GamesDetailView(game: game)
//                        }
//                    }
//
            }
        }
    }
}

#Preview {
    ContentView()
}
