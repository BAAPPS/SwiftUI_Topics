//
//  ProductViewModel.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/9/25.
//

import Foundation
import SwiftData

@Observable
final class ProductViewModel: ModelContextInitializable {
    var products: [Product] = []
    
    private let context: ModelContext
    
    required init(context: ModelContext) {
        self.context = context
    }
    
    func load() {
        loadProducts()
    }
    
    func loadProducts() {
        let result: Result<[ProductJSON], Error> = Bundle.main.decode("products.json")
        
        switch result {
        case .success(let decodedJSON):
            // Map JSON models to SwiftData Product models
            let swiftDataProducts = decodedJSON.map { json -> Product in
                let rating = Rating(rating: json.rating.rate, count: json.rating.count)
                
                return Product(
                    id: json.id,
                    productDescription: json.productDescription,
                    category: json.category,
                    image: json.image,
                    price: json.price,
                    title: json.title,
                    rating: rating
                )
            }
            
            swiftDataProducts.forEach { context.insert($0) }
            
            self.products = swiftDataProducts
            
        case .failure(let error):
            print("Failed to decode products.json: \(error.localizedDescription)")
        }
    }
}
