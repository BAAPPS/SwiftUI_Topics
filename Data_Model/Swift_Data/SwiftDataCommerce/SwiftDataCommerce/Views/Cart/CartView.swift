//
//  CartView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/12/25.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Environment(CartViewModel.self) var cartVM
    private let MAX_QUANTITY = 5
    
    
    var body: some View {
        List {
            ForEach(cartVM.items, id: \.self) { item in
                VStack(alignment:.leading, spacing:5) {
                    let quantityBinding = Binding(
                        get: { String(item.quantity) },
                        set: { newValue in
                            if let intValue = Int(newValue) {
                                cartVM.updateQuantity(for: item, quantity: min(intValue, MAX_QUANTITY))
                            }
                        }
                    )
                    
                    HStack {
                        Text(item.product.title)
                            .lineLimit(1)
                            .padding(.top, 5)
                            .accessibilityHidden(true)
                        Spacer()
                    }
                    
                    
                    HStack{
                        HStack {
                            Button(role: .destructive) {
                                cartVM.clearItem(item)
                            } label: {
                                Image(systemName:"trash")
                            }
                            .foregroundColor(.red)
                            .accessibilityLabel("Remove \(item.product.title) from cart")
                            .accessibilityHint("Tap to remove this item from your cart")
                            
                            HStack{
                                Text("Qty")
                                    .font(.subheadline)
                                    .accessibilityHidden(true)
                                
                                TextField("", text: quantityBinding)
                                    .frame(width: 50)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .foregroundStyle(item.quantity == MAX_QUANTITY ? Color.red : Color.black)
                                    .fontWeight(.bold)
                                    .accessibilityLabel("Quantity for \(item.product.title)")
                                    .accessibilityValue("\(item.quantity)")
                                    .accessibilityHint("Enter a quantity up to \(MAX_QUANTITY)")
                                
                                
                                
                                Text("Max(\(MAX_QUANTITY))")
                                    .font(.caption)
                                    .foregroundStyle(Color.red)
                                    .opacity(item.quantity == MAX_QUANTITY ? 1 : 0)
                                    .accessibilityHidden(true)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text("$\(Double(item.quantity) * item.product.price, specifier: "%.2f")")
                                .frame(width: 80, alignment: .trailing)
                                .accessibilityLabel("Price for \(item.product.title)")
                                .accessibilityValue("$\(Double(item.quantity) * item.product.price, specifier: "%.2f")")
                        }
                        
                    }
                }
                .accessibilityElement(children: .combine)
                
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        cartVM.removeItem(item)
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                    .accessibilityLabel("Remove \(item.product.title) from cart")
                }
            }
            
            HStack {
                Text("Total:")
                    .fontWeight(.bold)
                Spacer()
                Text("$\(cartVM.totalPrice, specifier: "%.2f")")
                    .fontWeight(.bold)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Total price")
            .accessibilityValue("$\(cartVM.totalPrice, specifier: "%.2f")")
        }
        .navigationTitle("Cart")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    cartVM.clearCart()
                } label: {
                    Label("Clear All", systemImage: "trash.circle")
                }
                .accessibilityLabel("Clear all items from cart")
                .accessibilityHint("Double tap to remove all items from your shopping cart")
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
    return NavigationStack {
        CartView()
            .environment(\.modelContext, context)
            .environment(cartVM)
    }
}
