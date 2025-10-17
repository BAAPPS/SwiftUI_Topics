//
//  ExerciseListView.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @State private var addExercise = false
    @State private var selectedExercise: Exercise? = nil
    
    
    
    var body: some View {
        ContextViewLoader { (vm: ExerciseViewModel) in
            Group{
                if vm.items.isEmpty{
                    VStack {
                        Spacer()
                        Text("No exercises added just yet. Create one by tapping the plus (+) button in the top right corner.")
                            .font(.title3)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List{
                        ForEach(vm.items) { exercise  in
                            let exerciseVolume = Double(exercise.reps * exercise.sets) * exercise.weight
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(exercise.name)
                                        .foregroundStyle(Color.black.opacity(0.7))
                                        .fontWeight(.medium)
                                    HStack{
                                        StatLabelView(
                                            label: exercise.reps > 1 ? "Reps" : "Rep",
                                            value: "\(exercise.reps)"
                                        )
                                        dividerViewModifier(height:10)
                                        StatLabelView(
                                            label: exercise.sets > 1 ? "Sets" : "Set",
                                            value: "\(exercise.sets)"
                                        )
                                        dividerViewModifier(height:10)
                                        StatLabelView(
                                            label: exercise.weight > 1 ? "Weights" : "Weight",
                                            value: "\(exercise.weight)"
                                        )
                                        Spacer()
                                        Text("\(exerciseVolume.emoji) \(Int(exerciseVolume)) lb")
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.orange)
                                    }
                                }
                                Spacer()
                                
                            }
                            .contentShape(Rectangle())
                            .onTapGesture{
                                selectedExercise = exercise
                            }
                            
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let exercise = vm.items[index]
                                vm.deleteExercise(exercise)
                                
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addExercise = true
                    }){
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Text("Total Volume:")
                            .font(.subheadline)
                        Text("Total: \(vm.totalVolume.emoji) \(Int(vm.totalVolume)) lb")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.orange)
                    }
                }
            }
            .navigationTitle("My Exercises")
            // SwiftUI fullScreenCover rules:
            // Bool-based cover: opens when the binding is true, closes when false.
            // Item-based cover: opens when the binding is non-nil, closes when set to nil.
            // You cannot use a single optional item to handle both "Add" (nil) and "Edit" (non-nil) cases, because nil never triggers the cover.
            // Therefore, separate state variables are needed: one Bool for Add, one optional item for Edit.
            .fullScreenCover(isPresented: $addExercise) {
                ExerciseFormView()
                    .environment(vm)
            }
            .fullScreenCover(item: $selectedExercise) { exercise in
                ExerciseFormView(exercise: exercise)
                    .environment(vm)
            }
            
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, Workout.self, configurations: config)
    let context = ModelContext(container)
    
    // Seed exercises in the context
    let bench = Exercise(name: "Bench Press", reps: 10, sets: 3, weight: 100)
    let pushups = Exercise(name: "Push-Ups", reps: 15, sets: 3, weight: 0)
    let dumbbell = Exercise(name: "Dumbbell Press", reps: 10, sets: 5, weight: 65)
    
    
    context.insert(bench)
    context.insert(pushups)
    context.insert(dumbbell)
    
    return NavigationStack {
        ExerciseListView()
            .environment(\.modelContext, context)
    }
}
