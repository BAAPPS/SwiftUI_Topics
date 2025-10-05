//
//  MovieListGridView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI
import SwiftData

struct MoviesListGridView: View {
    @Environment(MoviesViewModel.self) var moviesVM
    @Environment(MovieViewMode.self) var movieViewMode
    @State private var previousMode: MovieViewMode.ViewMode = .list
    
    
    @State private var addMoviesClicked = false
    @State private var sortAscending = true
    
    
    
    var body: some View {
        VStack {
            
            // MARK: — Toggle Buttons
            HStack(spacing: 10){
                Button{
                    movieViewMode.currentMode = .grid
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .foregroundColor(movieViewMode.currentMode == .grid ? .blue : .gray)
                }
                
                Button{
                    movieViewMode.currentMode = .list
                }  label: {
                    Image(systemName: "list.bullet")
                        .foregroundColor(movieViewMode.currentMode == .list ? .blue : .gray)
                }
            }
            .padding()
            .frame(maxWidth:.infinity, alignment: .center)
            .background(Color.clear)
            
            Spacer()
            
            // MARK: — Main Content
            Group {
                switch movieViewMode.currentMode {
                case .grid:
                    MovieGridView(sortAscending: sortAscending)
                        .id(sortAscending)
                        .transition(movieViewMode.currentMode.transition())
                        .animation(.easeInOut(duration: 0.25), value: sortAscending)
                case .list:
                    MoviesListView(sortAscending: sortAscending)
                        .id(sortAscending)
                        .transition(movieViewMode.currentMode.transition())
                        .animation(.easeInOut(duration: 0.25), value: sortAscending)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: movieViewMode.currentMode)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            // We use a ZStack with conditional Text views and `.transition(.opacity)`
            // because `.navigationTitle` changes don't animate by default.
            // This forces SwiftUI to treat the title as a view insertion/removal,
            // allowing us to animate the change between "Movies List" and "Movies Grid".
            ToolbarItem(placement: .principal) {
                ZStack {
                    if movieViewMode.currentMode == .list {
                        Text("Movies List")
                            .font(.headline)
                            .transition(.opacity)
                    } else {
                        Text("Movies Grid")
                            .font(.headline)
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: movieViewMode.currentMode)
                .onChange(of: movieViewMode.currentMode) {_, newMode in
                    previousMode = newMode == .grid ? .list : .grid
                }
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Explicit Animation
                    withAnimation(.easeInOut(duration: 0.25)) {
                        sortAscending.toggle()
                    }
                } label: {
                    Image(systemName: sortAscending ? "arrow.up" : "arrow.down")
                    // Implicit Animation
                    // .animation(.spring(), value: sortAscending)
                }
                .accessibilityLabel("Sort movies")
                .accessibilityHint("Toggles between ascending and descending order")
            }
            
            
            ToolbarItem(placement:.navigationBarTrailing){
                Button(action: {
                    addMoviesClicked = true
                }) {
                    Image(systemName: "plus")
                        .accessibilityHidden(true)
                }
                .accessibilityLabel("Add note")
                .accessibilityHint("Opens a screen to create a new note")
            }
        }
        .navigationDestination(isPresented: $addMoviesClicked) {
            MovieCreationView()
                .environment(moviesVM)
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
    NavigationStack {
        MoviesListGridView()
            .environment(\.modelContext, context)
            .environment(MoviesViewModel(context: context))
            .environment(MovieViewMode())
    }
}
