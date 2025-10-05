//
//  MultipleSelectionPicker.swift
//  SwiftWatchlist
//
//  Created by D F on 10/5/25.
//

import SwiftUI

struct MultipleSelectionPicker<Option: Identifiable & Hashable & CustomStringConvertible>: View {
    let title: String
    let options: [Option]
    @Binding var selections: Set<Option>

    var body: some View {
        NavigationLink {
            List(options, id: \.self) { option in
                HStack {
                    Text(option.description) // dynamic text
                    Spacer()
                    if selections.contains(option) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if selections.contains(option) {
                        selections.remove(option)
                    } else {
                        selections.insert(option)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                EditButton()
            }
        } label: {
            HStack {
                Text(selectedItemsLabel)
                    .foregroundColor(selections.isEmpty ? .secondary : .primary)
            }
        }
    }

    private var selectedItemsLabel: String {
        if selections.isEmpty {
            return title // fallback
        }
        return selections
            .map { "\($0)" }
            .sorted()
            .joined(separator: ", ")
    }
}
