//
//  SearchbarView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .accessibilityHidden(true) // prevent duplicate announcement
            }
            
            TextField("", text: $text)
                .onSubmit {
                    let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmed.isEmpty {
                        onCommit?()
                    }
                }
                .submitLabel(.search)
                .padding(10)
         
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .foregroundColor(.black)
        .padding(.horizontal)
        .accessibilityLabel("Search News")
        .accessibilityValue(text.isEmpty ? "No topic entered" : text)
        .accessibilityHint("Enter a topic like Netflix, Apple, or Tesla")
    }
}


#Preview {
    @Previewable @State var searchText = ""
    return SearchBarView(text: $searchText, placeholder: "Search by topic") {
        print("Search committed:", searchText)
    }
}
