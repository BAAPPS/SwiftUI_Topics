//
//  ContentView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var movieVM: MoviesViewModel
    let movieViewMode = MovieViewMode()
    
    init(context: ModelContext){
        _movieVM = State(wrappedValue: MoviesViewModel(context: context))
    }
    var body: some View {
        NavigationStack {
            MoviesListGridView()
                .environment(movieVM)
                .navigationDestination(for:Movie.self) { movie in
                    MovieDetailView(movie: movie)
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
    ContentView(context: context)
        .environment(\.modelContext, context)
        .environment(MovieViewMode())
    
}
