//
//  GamesDetailView.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import SwiftUI
import Kingfisher

struct GamesDetailView: View {
    let game: GamesModel
    var body: some View {
        ZStack {
            Color.gray800
                .ignoresSafeArea()
            
            VStack {
                // Game Cover
                KFImage.url(from: game.cover?.url)
                    .placeholder{
                        ZStack {
                            Color.black.opacity(0.2)
                            ProgressView()
                        }
                    }
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .accessibilityHidden(true) // Decorative
                
                // Game Name + Release Date Row
                HStack {
                    IconTextRow(systemName: "gamecontroller.fill", text: game.name)
                        .accessibilitySortPriority(2) // Read first
                    
                    dividerModifier()
                        .accessibilityHidden(true)
                    
                    IconTextRow(systemName: "calendar", text: Dates.formattedReleaseDate(from: game.firstReleaseDate))
                        .accessibilitySortPriority(1) // Read second
                }
                .padding(.top, 20)
                .accessibilityElement(children: .combine)
                
                // Genres
                if let genres = game.genres {
                    IconTextRow(systemName: "tag.fill", text: genres.map { $0.name }.joined(separator: ", "))
                        .padding(.top, 10)
                        .accessibilitySortPriority(0)
                    
                }
                
                
                
                // Summary
                if let summary = game.summary {
                    Text(summary)
                        .foregroundColor(.gray200)
                        .padding(.top, 10)
                        .padding(.horizontal, 5)
                        .frame(maxWidth:.infinity, alignment: .center)
                        .accessibilityAddTraits(.isStaticText)
                        .accessibilitySortPriority(-1) // read last

                }
                
                Spacer()
                
                // External Link
                if let url = URL(string: game.url) {
                    Link("View \(game.name) on IGDB", destination: url)
                        .font(.headline)
                        .foregroundColor(.gray200)
                        .underline()
                        .accessibilityLabel("View \(game.name) on IGDB")
                        .accessibilityHint("Opens IGDB page in browser")
                        .accessibilitySortPriority(-2) // read after summary
                    
                }
                
                Spacer()
                
                
            }
            
            
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
        .backButton()
    }
}

#Preview {
    NavigationStack {
        GamesDetailView(game: GamesModel.example)
    }
}
