//
//  ContentView.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showsVM = ShowsVM()
    var body: some View {
        NavigationStack {
            ShowsListView()
                .environment(showsVM)
        }
     
    }
}

#Preview {
    ContentView()
}
