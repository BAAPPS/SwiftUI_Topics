//
//  ShowsListView.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI

struct ShowsListView: View {
    @Environment(ShowsVM.self) var showsVM
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(showsVM.shows) {show in
                    NavigationLink(value: show) {
                        HStack(alignment: .center) {
                            Text(show.title).font(.headline)
                            Text(show.subtitle).font(.subheadline)
                        }
                        .padding()
                        .background(Color(hex:"#fda4a8"))
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .visualEffect { content, proxy in
                            // tilt effect
                            content
                                .rotation3DEffect(
                                    .degrees(-proxy.frame(in: .global).minY) / 25,
                                    axis: (x: 1, y: 0, z: 0)
                                )
                        }
                    }
                    .scrollTargetLayout()
                    .scrollTargetBehavior(.viewAligned)
                    .foregroundColor(Color(hex:"#540b0e"))
                    
                }
            }
        }
        .navigationTitle("Shows")
        .navigationDestination(for:ShowsModel.self) { show in
            ShowsDetailView(show:show)
        }
    }
}

#Preview {
    NavigationStack {
        ShowsListView()
            .environment(ShowsVM())
    }
}
