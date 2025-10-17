//
//  ContextViewLoader.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI
import SwiftData

struct ContextViewLoader<VM: ModelContextInitializable & AnyObject, Content: View> : View {
    
    @Environment(\.modelContext) var context
    @State private var viewModel: VM? = nil
    
    let content: (VM) -> Content
    
    var body: some View {
        Group {
            if let vm = viewModel {
                content(vm)
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            await initializeViewModel()
        }
    }
    
    private func initializeViewModel() async {
        guard viewModel == nil else { return }
        let vm = VM(context: context)
        vm.load()
        viewModel = vm
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, Workout.self, configurations: configuration)
    let context = ModelContext(container)
    ContextViewLoader { (vm: ExerciseViewModel) in
           VStack {
               Text("Loaded \(vm.items.count) snippets")
                   .font(.headline)
           }
           .padding()
       }
       .environment(\.modelContext, context)
}
