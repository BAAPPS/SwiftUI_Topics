//
//  TabContentView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/12/25.
//

import SwiftUI
import SwiftData

struct TabContentView: View {
    @Environment(\.modelContext) private var context
    @Environment(CartViewModel.self) var cartVM
    @Binding var selectedTab: AppTab
    var body: some View {
        Group{
            
            switch selectedTab {
            case .home:
                ProductView()
                    .environment(cartVM)
                    .environment(\.modelContext, context)
            case .cart:
                CartView()
                    .environment(cartVM)
                    .environment(\.modelContext, context)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Tab content for \(selectedTab.title)")
        .onChange(of: selectedTab) {_, newTab in
            // VoiceOver will announce the new tab content
            UIAccessibility.post(notification: .layoutChanged, argument: nil)
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: AppTab = .cart
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Product.self, Rating.self, Cart.self, CartItem.self,
        configurations: config
    )
    let context = ModelContext(container)
    let previewCart = Cart()
    
    let dummyRating1 = Rating(rating: 4.2, count: 259)
    let product1 = Product(
        id: 1,
        productDescription: "21.5 inches Full HD (1920 x 1080) widescreen IPS display...",
        category: "electronics",
        image: "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_t.png",
        price: 599,
        title: "Acer SB220Q 21.5\" Full HD IPS",
        rating: dummyRating1
    )
    
    let dummyRating2 = Rating(rating: 3.8, count: 120)
    let product2 = Product(
        id: 2,
        productDescription: "High performance wireless mouse with ergonomic design...",
        category: "electronics",
        image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
        price: 49,
        title: "Logitech Wireless Mouse",
        rating: dummyRating2
    )
    
    let item1 = CartItem(quantity: 2, product: product1, cart: previewCart)
    let item2 = CartItem(quantity: 1, product: product2, cart: previewCart)
    context.insert(item1)
    context.insert(item2)
    
    let cartVM = CartViewModel(context: context)
    return TabContentView(selectedTab: $selectedTab)
        .environment(\.modelContext,context)
        .environment(cartVM)
}
