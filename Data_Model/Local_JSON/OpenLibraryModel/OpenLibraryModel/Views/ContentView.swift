//
//  ContentView.swift
//  OpenLibraryModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var booksVM: BooksVM = .init()
    var body: some View {
        NavigationStack {
            BooksGridView()
                .environment(booksVM)
        }
    }
}

#Preview {
    ContentView()
}
