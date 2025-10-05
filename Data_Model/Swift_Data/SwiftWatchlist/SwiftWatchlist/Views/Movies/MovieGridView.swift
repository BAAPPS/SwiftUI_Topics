//
//  MovieGridView.swift
//  SwiftWatchlist
//
//  Created by D F on 10/5/25.
//

import SwiftUI
import SwiftData
import Kingfisher

struct MovieGridView: View {
    @Environment(MoviesViewModel.self) var movieVM
    @Query(sort: \Movie.title) var movies: [Movie]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns:columns) {
                ForEach(movies) { movie  in
                    ZStack{
                        KFImage(URL(string: movie.posterPath))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .accessibilityHidden(true)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlayEffect(opacity: 0.3)
                        
                        VStack {
                            NavigationLink(value: movie) {
                                Image(systemName: "info.circle.fill")
                                    .font(.title2)
                                    .padding(2)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                                    .accessibilityLabel("Show details for \(movie.title)")
                                    .accessibilityHint("Tap to view \(movie.title) details")
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            
                            Spacer()
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Movie.self, Genre.self, Tag.self, Rating.self,
        configurations: config
    )
    let context = ModelContext(container)
    
    MovieGridView()
        .environment(\.modelContext, context)
        .environment(MoviesViewModel(context:context))
    
}
