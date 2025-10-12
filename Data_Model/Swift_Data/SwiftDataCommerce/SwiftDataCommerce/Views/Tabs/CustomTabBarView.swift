//
//  CustomTabBarView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/12/25.
//

import SwiftUI
import SwiftData

struct CustomTabBarView: View {
    @Environment(CartViewModel.self) var cartVM
    @State private var selectedTab: AppTab = .home

    var body: some View {
        ZStack{
            TabContentView(selectedTab: $selectedTab)
                .environment(cartVM)
            
            VStack{
                Spacer()
                TabBarView(selectedTab: $selectedTab)
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
        CustomTabBarView()
            .environment(\.modelContext, context)
    }
}
