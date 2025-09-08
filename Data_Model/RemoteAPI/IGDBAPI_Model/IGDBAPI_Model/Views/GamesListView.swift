//
//  GamesListView.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import SwiftUI
import Kingfisher

struct GamesListView: View {
    @Environment(GamesViewModel.self) var gamesVM
    var body: some View {
        VStack {
            if gamesVM.isLoading {
                ProgressView()
            }else if let error = gamesVM.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                List(gamesVM.games) {game in
                    HStack(alignment: .center, spacing: 10) {
                        
                        Text(game.name)
                            .foregroundColor(Color.gray100)
                            .padding(.horizontal, 5)
                            .accessibilityLabel(game.name)
                            .accessibilityAddTraits(.isHeader)
                        
                        KFImage.url(from: game.cover?.url)
                            .placeholder{
                                ZStack {
                                    Color.black.opacity(0.2)
                                    ProgressView()
                                }
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width:80, height:80)
                            .accessibilityHidden(true) 
                        
                        
                        
                        NavigationLink(value: game) {
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .padding(2)
                                .foregroundColor(Color.gray200)
                                .shadow(radius: 4)
                                .frame(maxWidth:.infinity, alignment: .trailing)
                                .accessibilityLabel("Show details for \(game.name)")
                                .accessibilityHint("Tap to view \(game.name) details")
                        }
                        
                        
                    }
                    .padding()
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Color.gray100.opacity(0.5))
                    .accessibilityElement(children: .contain)
                    
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        } .onAppear {
            gamesVM.fetchGames()
        }
        .navigationTitle("Games")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        
        ZStack {
            
            Color.gray800
                .ignoresSafeArea()
            
            GamesListView()
                .environment(GamesViewModel())
        }
    }
}
