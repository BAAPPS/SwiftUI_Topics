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
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var releaseYear: String = ""
    @State private var status: MovieStatus = .toWatch
    @State private var overview = ""
    @State private var backdropPath = ""
    @State private var posterPath = ""
    @State private var selectedGenres: Set<GenreType> = []
    @State private var selectedTags: Set<TagType> = []
    @State private var ratingValue: String = ""
    @State private var ratingReview = ""
    
    var body: some View {
        Form {
            Section(header: Text("Movie Info")) {
                TextField("Title", text: $title)
                TextField("Release Year", text: $releaseYear)
                    .keyboardType(.numberPad)
                Picker("Status", selection: $status) {
                    ForEach(MovieStatus.allCases) { status in
                        Text(status.displayName).tag(status)
                    }
                }
                TextField("Overview", text: $overview)
                TextField("Backdrop URL", text: $backdropPath)
                TextField("Poster URL", text: $posterPath)
            }
            
            Section(header: Text("Genres")) {
                MultipleSelectionPicker(title: "Select Genres", options: GenreType.allCases, selections: $selectedGenres)
            }
            
            Section(header: Text("Tags")) {
                MultipleSelectionPicker(title: "Select Tags", options: TagType.allCases, selections: $selectedTags)
            }
            
            
            Section(header: Text("Rating")) {
                TextField("Rating (0-10)", text: $ratingValue)
                    .keyboardType(.decimalPad)
                TextField("Review", text: $ratingReview)
            }
            
            Section {
                Button(action: {
                    saveMovie()
                }) {
                    let buttonText = title.isEmpty ? "Add Movie" : "Add \(title)"
                    Text(buttonText)
                        .frame(maxWidth:.infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Add Movie")
    }
    
    private func saveMovie() {
        let genres = selectedGenres.map { Genre(type: $0) }
        let tags = selectedTags.map { Tag(content: .custom($0.rawValue)) }
        
        moviesVM.addMovie(
            title: title,
            releaseYear: Int(releaseYear),
            status: status,
            overview: overview,
            backdropPath: backdropPath,
            posterPath: posterPath,
            genres: genres,
            tags: tags,
            ratingValue: Double(ratingValue),
            ratingReview: ratingReview.isEmpty ? nil : ratingReview
        )
        
        dismiss()
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
