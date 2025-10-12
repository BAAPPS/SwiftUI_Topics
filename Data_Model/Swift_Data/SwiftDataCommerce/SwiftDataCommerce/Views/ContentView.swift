//
//  ContentView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var cartVM: CartViewModel
    
    init(context: ModelContext) {
        _cartVM = State(wrappedValue: CartViewModel(context: context))
    }
    var body: some View {
        NavigationStack {
            CustomTabBarView()
                .environment(cartVM)
        }
        // Change default blue coloring to own colors due to ScrollView
        .buttonStyle(PlainButtonStyle())
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Product.self,Rating.self, Cart.self, CartItem.self, configurations: config)
    let context = ModelContext(container)
    
   ContentView(context: context)
        .environment(\.modelContext, context)
}
