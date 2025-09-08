//
//  GamesGridView.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import SwiftUI
import Kingfisher

struct GamesGridView: View {
    @Environment(GamesViewModel.self) var gamesVM
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(gamesVM.games) { game in
                    ZStack{
                        KFImage.url(from: game.cover?.url)
                            .placeholder{
                                ZStack {
                                    Color.black.opacity(0.2)
                                    ProgressView()
                                }
                            }
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(8)
                            .accessibilityHidden(true) // Image is decorative
                            .overlayEffect(opacity: 0.7)
                        
                        VStack {
                            NavigationLink(value: game) {
                                Image(systemName: "info.circle.fill")
                                    .font(.title2)
                                    .padding(2)
                                    .background(Color.gray300)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                                    .accessibilityLabel("Show details for \(game.name)")
                                    .accessibilityHint("Tap to view \(game.name) details")
                                
                            }
                            .frame(maxWidth:.infinity, alignment: .trailing)
                            .padding(.vertical, 13)
                            .padding(.horizontal, 10)
                            
                            
                            Spacer()
                            
                            Text(game.name)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.gray100)
                                .frame(maxWidth:.infinity, alignment: .center)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 20)
                            // Make name its own accessibility element
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel(game.name)
                                .accessibilityAddTraits(.isHeader)
                        }
  
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.gray700)
                    .cornerRadius(8)
                    .padding(.top, 15)
                }
            }
            .padding()
        }
        .onAppear {
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
            
            GamesGridView()
                .environment(GamesViewModel())
        }
    }
}
