//
//  ContentView.swift
//  HarvardArtModel
//
//  Created by D F on 9/6/25.
//

import SwiftUI

struct ContentView: View {
    let imagesVM = ImagesViewModel() 
    var body: some View {
        NavigationStack {
            ImagesView()
                .environment(imagesVM)
        }
    }
}

#Preview {
    ContentView()
        .environment(ImagesViewModel())
}
