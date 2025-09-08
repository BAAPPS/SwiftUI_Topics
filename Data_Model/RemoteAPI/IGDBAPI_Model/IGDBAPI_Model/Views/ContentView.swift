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
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray800
                    .ignoresSafeArea()
                GamesListGridView()
                    .environment(gamesVM)
                    .environment(gameViewModeModel)
                    .navigationDestination(for: GamesModel.self) { game in
                        GamesDetailView(game: game)
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
