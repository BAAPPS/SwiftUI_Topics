//
//  ProductView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/10/25.
//

import SwiftUI
import SwiftData

struct ProductView: View {
    @Environment(\.modelContext) private var context
    @State private var productVM: ProductViewModel?
    @Query(sort: \Product.category, order: .forward) private var products:[Product]
    
    private var groupedProductsSorted: [(category: String, products: [Product])] {
        GroupingHelper.group(products, by: \.category)
            .map {
                ( category: $0.key,
                  products: $0.value.sorted(by:{ $0.title < $1.title }))
            }
            .sorted(by: { $0.category < $1.category })
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            ContextViewModelLoader { (vm: ProductViewModel) in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(groupedProductsSorted,id:\.category) { group in
                            Text(group.category.capitalized)
                                .font(.title2)
                                .bold()
                                .padding(.leading)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(group.products, id:\.id) { product in
                                    NavigationLink(value:product) {
                                        ProductCardView(product: product)
                                    }
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Product.self) { product in
                        ProductDetailsView(product: product, context: context)
                    }
                }
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
    NavigationStack {
        ProductView()
            .environment(\.modelContext, context)
    }
}
