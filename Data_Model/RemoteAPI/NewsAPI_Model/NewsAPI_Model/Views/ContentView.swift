//
//  ContentView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

struct ContentView: View {
    let newsViewModel = NewsViewModel()
    var body: some View {
        CustomTabBarView()
            .environment(newsViewModel)
    }
}

#Preview {
    ContentView()
}
