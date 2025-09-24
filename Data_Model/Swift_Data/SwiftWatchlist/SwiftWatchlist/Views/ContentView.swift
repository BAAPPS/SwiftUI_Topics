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
    
    init(context: ModelContext){
        _movieVM = State(wrappedValue: MoviesViewModel(context: context))
    }
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    let container = try! ModelContainer(for: Movie.self)
    let context = ModelContext(container)
    
    ContentView(context: context)
        .environment(\.modelContext, context)
    
}
