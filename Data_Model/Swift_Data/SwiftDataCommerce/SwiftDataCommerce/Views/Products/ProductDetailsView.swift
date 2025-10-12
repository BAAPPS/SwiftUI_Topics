//
//  ProductDetailsView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/10/25.
//

import SwiftUI
import SwiftData

struct ProductDetailsView: View {
    private let MAXLIMIT = 5
    let product: Product
    @State private var quantity: Int = 1
    @State private var addToCart = false
    @State private var cartVM: CartViewModel
    
    init(product: Product, context: ModelContext) {
        self.product = product
        _cartVM = State(wrappedValue: CartViewModel(cart: Cart(), context: context))
    }

    var body: some View {
        ScrollView {
            VStack{
                Text(product.title)
                    .font(.title3)
                    .fontWeight(.regular)
                
                if let ratingValue = product.rating?.rating,
                   let count = product.rating?.count{
                    
                    HStack {
                        StarRatingView(rating: ratingValue, starSize: 14)
                        Text("(\(count))")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.black.opacity(0.5))
                    }
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Text("No rating yet")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                }
                
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .accessibilityHidden(true)
                } placeholder: {
                    ProgressView()
                }
                .padding(8)
                
                HStack(spacing: 2) {
                    Text("$")
                        .font(.system(size: 16, weight:.regular))
                        .foregroundColor(.black.opacity(0.7))
                        .baselineOffset(2) // nudges the $ vertically
                    Text(product.price, format: .number.precision(.fractionLength(0...2)))
                        .font(.title)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                HStack(spacing: 16){
                    Text("Quantity:")
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    HStack{
                        Button {
                            if quantity > 1 { quantity -= 1 }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                                .foregroundColor(quantity > 1 ? .blue : .gray)
                        }
                        .offset(x:5)
                        
                        Divider()
                            .frame(width: 1, height: 44)
                            .background(Color.gray.opacity(0.5))
                        
                        ZStack {
                            Text("\(quantity)")
                                .frame(width: 60, height: 25)
                                .font(.body)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .foregroundColor(quantity == MAXLIMIT ? .red: .black)
                                .animation(.none, value: quantity)
                            
                            if quantity == MAXLIMIT {
                                Text("Limit \(MAXLIMIT)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 6)
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    .frame(width: 70)
                                    .offset(x: -5, y: -35)
                                    .transition(.scale)
                            }
                            
                            
                            
                        }
                        .frame(width: 60, height: 44)
                        .animation(.easeInOut, value: quantity)
                        
                        Divider()
                            .frame(width: 1, height: 44)
                            .background(Color.gray.opacity(0.5))
                        
                        
                        Button {
                            if quantity < 5 { quantity += 1 } // max limit 5
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(quantity < MAXLIMIT ? .blue : .gray)
                        }
                        .offset(x:-5)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                    )
                }
                .padding(.top, 25)
                
                VStack{
                    Button(action: {
                        cartVM.addToCart(product: product, quantity: quantity)
                        addToCart = true
                    }) {
                       Text("Add to cart")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(width:300)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding(.top, 10)
                
                Divider()
                
                VStack(alignment:.leading, spacing: 5){
                    Text("Details")
                        .font(.title2)
                        .bold()
                    
                    
                    Text(product.productDescription)
                        .lineSpacing(10)
                        .padding(.top, 10)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
        .navigationDestination(isPresented: $addToCart) {
            CartView()
                .environment(cartVM)
        }
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Product.self, Rating.self, Cart.self, CartItem.self,
        configurations: config
    )
    let context = ModelContext(container)
    
    let dummyRating = Rating(rating: 4.2, count: 259)
    let dummyProduct = Product(
        id: 1,
        productDescription: "21.5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon FreeSync technology...",
        category: "electronics",
        image: "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_t.png",
        price: 599,
        title: "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
        rating: dummyRating
    )
    
    ProductDetailsView(product: dummyProduct, context: context)
        .environment(\.modelContext, context)
}
