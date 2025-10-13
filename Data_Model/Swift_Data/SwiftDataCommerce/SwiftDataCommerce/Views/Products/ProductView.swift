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
    @Environment(CartViewModel.self) var cartVM
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
                            .accessibilityLabel("Products in category \(group.category.capitalized)")
                            .accessibilityAddTraits(.isHeader)
                        // Use persistentModelID instead of product.id for SwiftData models in ForEach/LazyVGrid.
                        // This ensures unique, stable identifiers across SwiftUI collection views (LazyVGrid, ForEach, etc.),
                        // preventing duplicate-ID warnings and allowing SwiftUI to correctly track each Product
                        // even when items are added, removed, or updated in the underlying ModelContext.
                        LazyVGrid(columns: columns) {
                            ForEach(group.products, id:\.persistentModelID) { product in
                                NavigationLink(value:product) {
                                    ProductCardView(product: product)
                                }
                            }
                        }
                    }
                }
                .navigationDestination(for: Product.self) { product in
                    ProductDetailsView(product: product)
                        .environment(cartVM)
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
    let cartVM = CartViewModel(context: context)
    NavigationStack {
        ProductView()
            .environment(\.modelContext, context)
            .environment(cartVM)
    }
}
