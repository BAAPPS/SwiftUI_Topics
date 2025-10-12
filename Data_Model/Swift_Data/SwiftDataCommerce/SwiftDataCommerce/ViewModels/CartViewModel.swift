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
    
    init(cart: Cart, context: ModelContext) {
        self.cart = cart
        self.context = context
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
    
    /// Updates quantity of an existing cart item
    func updateQuantity(for item: CartItem, quantity: Int, maxQuantity: Int = 5) {
        item.quantity = min(quantity, maxQuantity)
        save()
    }
    
    /// Removes a cart item
    func removeItem(_ item: CartItem) {
        context.delete(item)
        save()
    }
    
    /// Clears all items from the cart
    func clearCart() {
        for item in cart.items {
            context.delete(item)
        }
        save()
    }
    
    // MARK: - Private Save Helper
    private func save() {
        do {
            try context.save()
        } catch {
            print("Error saving cart: \(error.localizedDescription)")
        }
    }
}
