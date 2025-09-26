//
//  IconTextRow.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import Foundation
import SwiftUI

struct IconTextRow: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(.blue.opacity(0.7))
                .font(.title2)
                .frame(width: 20, alignment: .center)
            Text(text)
                . font(.title3)
                .foregroundColor(.black.opacity(0.7))
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(text)")
        .accessibilityAddTraits(.isStaticText)
    }
}
