//
//  GamesListGridView.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import SwiftUI

struct GamesListGridView: View {
    @Environment(GamesViewModel.self) var gamesVM
    @Environment(GamesViewModeModel.self) var gamesViewModeModel
    
    var body: some View {
        VStack {
            // Toggle buttons
            HStack(spacing:20) {
                Button{
                    gamesViewModeModel.currentMode = .grid
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .foregroundColor(gamesViewModeModel.currentMode == .grid ? .blue : .gray100)
                }
                
                Button{
                    gamesViewModeModel.currentMode = .list
                }  label: {
                    Image(systemName: "list.bullet")
                        .foregroundColor(gamesViewModeModel.currentMode == .list ? .blue : .gray100)
                }
            }
            .padding()
            .frame(maxWidth:.infinity, alignment: .center)
            .background(Color.gray800)
            
            Spacer()
            
            // Content
            switch gamesViewModeModel.currentMode {
            case .grid:
                GamesGridView()
            case .list:
                GamesListView()
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray800
            .ignoresSafeArea()
        GamesListGridView()
            .environment(GamesViewModel())
            .environment(GamesViewModeModel())
    }
}
