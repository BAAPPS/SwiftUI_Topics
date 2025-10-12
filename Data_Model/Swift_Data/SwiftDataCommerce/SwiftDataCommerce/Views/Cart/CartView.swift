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
                    
                    Text(item.product.title)
                        .lineLimit(1)
                        .padding(.top, 5)
                    
                    Spacer()
                    
                    HStack{
                        HStack {
                            Button(role: .destructive) {
                                cartVM.clearItem(item)
                            } label: {
                                Image(systemName:"trash")
                            }
                            .foregroundColor(.red)
                            HStack{
                                Text("Qty")
                                    .font(.subheadline)
                                
                                TextField("", text: quantityBinding)
                                    .frame(width: 50)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .foregroundStyle(item.quantity == MAX_QUANTITY ? Color.red : Color.black)
                                    .fontWeight(.bold)
                                
                                
                                Text("Max(\(MAX_QUANTITY))")
                                    .font(.caption)
                                    .foregroundStyle(Color.red)
                                    .opacity(item.quantity == MAX_QUANTITY ? 1 : 0)
                            }
                        }
                        
                        Spacer()
                        
                        Text("$\(Double(item.quantity) * item.product.price, specifier: "%.2f")")
                            .frame(width: 80, alignment: .trailing)
                        
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        cartVM.removeItem(item)
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                }
            }
            
            HStack {
                Text("Total:")
                    .fontWeight(.bold)
                Spacer()
                Text("$\(cartVM.totalPrice, specifier: "%.2f")")
                    .fontWeight(.bold)
            }
        }
        .navigationTitle("Cart")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    cartVM.clearCart()
                } label: {
                    Label("Clear All", systemImage: "trash.circle")
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
   return NavigationStack {
        CartView()
            .environment(\.modelContext, context)
            .environment(cartVM)
    }
}
