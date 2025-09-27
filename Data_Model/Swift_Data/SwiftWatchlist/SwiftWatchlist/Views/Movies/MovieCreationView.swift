//
//  MovieCreationView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI
import SwiftData

struct MovieCreationView: View {
    @Environment(MoviesViewModel.self) var moviesVM
    
    var body: some View {
        Text("Create a movie view coming soon...")
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Movie.self, Genre.self, Tag.self, Rating.self,
        configurations: config
    )
    let context = ModelContext(container)
    MovieCreationView()
        .environment(MoviesViewModel(context: context))
}
