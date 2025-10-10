//
//  ContextViewModelLoader.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/10/25.
//

import SwiftUI
import SwiftData

struct ContextViewModelLoader<VM: ModelContextInitializable & AnyObject, Content:View>: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel: VM? = nil
    
    let content: (VM) -> Content
    
    var body: some View {
        Group {
            if let vm = viewModel {
                content(vm)
            }
            else {
                ProgressView("Loading...")
            }
        }
        .onAppear{
           guard viewModel == nil else { return }
            let vm = VM(context: context)
            vm.load()
            viewModel = vm
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Product.self, configurations: config)
    let context = ModelContext(container)

    ContextViewModelLoader { (vm: ProductViewModel) in
        VStack {
            Text("Loaded \(vm.products.count) products")
                .font(.headline)
            List(vm.products, id: \.id) { product in
                Text(product.title)
            }
        }
    }
    .environment(\.modelContext, context)


}
