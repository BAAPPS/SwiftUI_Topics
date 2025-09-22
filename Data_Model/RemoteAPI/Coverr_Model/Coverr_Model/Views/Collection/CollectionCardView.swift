//
//  CollectionCardView.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import SwiftUI
import Kingfisher

struct CollectionCardView: View {
    let collection: CollectionHitModel
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            VStack(alignment:.leading, spacing: 8){
                if let coverURL = collection.coverImage.flatMap(URL.init) {
                    KFImage(coverURL)
                        .placeholder {
                            ZStack {
                                Color.black.opacity(0.2)
                                ProgressView()
                            }
                        }
                        .resizable()
                        .scaledToFill()
                        .cornerRadiusModifier(cornerRadius, corners: [.topLeft, .topRight])
                        .accessibilityHidden(true)
                }
                
                Text(collection.title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black.opacity(0.9))
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(cornerRadius)
        .padding(.top, 20)
    }
}


#Preview {
    CollectionCardView(collection: .example, cornerRadius: 12)
}
