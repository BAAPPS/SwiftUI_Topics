//
//  ProductCardView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/10/25.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    var body: some View {
        VStack{
            ZStack {
                Color.gray
                    .opacity(0.3)
                    .cornerRadius(8)
                
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .padding(8)
            }
            .padding(.horizontal, 8)
            
            Text(product.title)
                .lineLimit(1)
                .padding(.horizontal, 8)
            
            if let ratingValue = product.rating?.rating,
               let count = product.rating?.count{
                
                HStack {
                    StarRatingView(rating: ratingValue, starSize: 14)
                    Text("\(count)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.5))
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("No rating yet")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
            }
            
            HStack(spacing: 2) {
                Text("$")
                    .font(.system(size: 15, weight:.regular))
                    .foregroundColor(.black.opacity(0.7))
                    .baselineOffset(2) // nudges the $ vertically
                Text(product.price, format: .number.precision(.fractionLength(0...2)))
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    let dummyRating = Rating(rating: 4.2, count: 259)
    let dummyProduct = Product(
        id: 1,
        productDescription: "This is a sample product description.",
        category: "electronics",
        image:"https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_t.png",
        price: 599.0,
        title: "Sample Product",
        rating: dummyRating
    )
    ProductCardView(product: dummyProduct)
        .frame(width:150, height:150)
}
