//
//  StateLabelView.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI

struct StatLabelView: View {
    let label: String
    let value: String
    var body: some View {
        HStack{
            Text("\(label):")
                .font(.caption)
            Text(value)
                .foregroundStyle(Color.black.opacity(0.8))
                .font(.caption)
                .bold()
                .italic()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    StatLabelView(label: "rep", value: "10")
}
