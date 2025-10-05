//
//  WatchListView.swift
//  SwiftWatchlist
//
//  Created by D F on 10/5/25.
//

import SwiftUI
import SwiftData
import Kingfisher

struct WatchListView: View {
    @Environment(\.modelContext) private var context
    @State private var watchingMovies: [Movie] = []
    @State private var watchedMovies: [Movie] = []
    
    
    var body: some View {
        List {
            if watchingMovies.isEmpty && watchedMovies.isEmpty {
                Text("Your watchlist is empty.")
                    .foregroundColor(.secondary)
                    .italic()
            }
            if !watchingMovies.isEmpty {
                Section("Watching") {
                    ForEach(watchingMovies) { movie in
                        MovieRow(movie: movie)
                    }
                }
            }
            
            if !watchedMovies.isEmpty {
                Section("Watched") {
                    ForEach(watchedMovies) { movie in
                        MovieRow(movie: movie)
                    }
                }
            }
        }
        .navigationTitle("Watchlist")
        .onAppear {
            loadWatchlist()
        }
    }
    
    private func loadWatchlist() {
        let toWatchDescriptor = FetchDescriptor<Movie>(
            predicate: #Predicate { $0.statusRaw == "watching" },
            sortBy: [SortDescriptor(\Movie.title)]
        )
        
        let watchingDescriptor = FetchDescriptor<Movie>(
            predicate: #Predicate { $0.statusRaw == "watched" },
            sortBy: [SortDescriptor(\Movie.title)]
        )
        
        watchingMovies = (try? context.fetch(toWatchDescriptor)) ?? []
        watchedMovies = (try? context.fetch(watchingDescriptor)) ?? []
    }
}
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, Genre.self, Tag.self, Rating.self, configurations: config)
    let context = ModelContext(container)
    
    Movie.exampleMovies.forEach { context.insert($0) }
    
    return WatchListView()
        .environment(\.modelContext, context)
}
