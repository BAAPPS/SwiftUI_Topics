//
//  CartViewModel.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/12/25.
//

import Foundation
import SwiftData


@Observable
final class CartViewModel {
    let context: ModelContext
    var cart: Cart
    
    var items: [CartItem] { cart.items }
    
    
    var totalPrice: Double {
        cart.totalPrice
    }
    
    // MARK: - Init
    init(context: ModelContext) {
        self.context = context
        
        // Try to fetch existing cart from persistent store
        if let existingCart = try? context.fetch(FetchDescriptor<Cart>()).first {
            self.cart = existingCart
            print("✅ Loaded existing cart from store.")
        } else {
            // Create a new one if none exist
            let newCart = Cart()
            context.insert(newCart)
            try? context.save()
            self.cart = newCart
            print("🆕 Created new cart and saved to persistent store.")
        }
    }
    
    // MARK: - Cart Operations
    
    /// Adds a product to the cart or increases quantity if it exists
    func addToCart(product: Product, quantity: Int = 1, maxQuantity: Int = 5) {
        if let existingItem = cart.items.first(where: { $0.product.id == product.id }) {
            existingItem.quantity = min(existingItem.quantity + quantity, maxQuantity)
        } else {
            let newItem = CartItem(quantity: min(quantity, maxQuantity), product: product, cart: cart)
            context.insert(newItem)
            // No need to append manually; SwiftData handles inverse
        }
        save()
    }
    
    func updateQuantity(for item: CartItem, quantity: Int, maxQuantity: Int = 5) {
        item.quantity = min(quantity, maxQuantity)
        save()
    }
    
    func removeItem(_ item: CartItem) {
        context.delete(item)
        save()
    }
    
    func clearCart() {
        for item in cart.items {
            context.delete(item)
        }
        save()
    }
    
    func clearItem(_ item: CartItem){
        context.delete(item)
        save()
    }
    
    // MARK: - Private Save Helper
    private func save() {
        do {
            try context.save()
            print("💾 Cart saved successfully.")
        } catch {
            print("⚠️ Error saving cart: \(error.localizedDescription)")
        }
    }
}
