//
//  ExerciseAddView.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI
import SwiftData


struct ExerciseFormView: View {
    @Environment(ExerciseViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    
    // Optional: if provided, we're editing
    let exercise: Exercise?
    
    @State private var nameText: String = ""
    @State private var repsText: String = ""
    @State private var setsText: String = ""
    @State private var weightText: String = ""
    
    init(exercise: Exercise? = nil) {
        self.exercise = exercise
        // State initializers can't depend on @Environment, so we fill them onAppear
    }
    
    var body: some View {
        @Bindable var vm = vm
        ZStack {
            Color.clear
                      
            VStack(alignment:.leading, spacing: 10) {
                
                Text("Max reps/sets: 999, Max weight: 999 lb")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                    .frame(maxWidth:.infinity, alignment: .center)
                            
                Text("Exercise Name")
                    .font(.title3)
                TextField("Exercise", text: $nameText)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                HStack(alignment: .center, spacing: 10) {
                    NumericFieldView(value: $repsText, label: "Reps", maxDigits: 3, isDecimal: false) { newValue in
                        vm.rep = Int(newValue)
                    }
                    NumericFieldView(value: $setsText, label: "Sets", maxDigits: 3, isDecimal: false) { newValue in
                        vm.sets = Int(newValue)
                    }
                    NumericFieldView(value: $weightText, label: "Weight (lb)", maxDigits: 3, isDecimal: true) { newValue in
                        vm.weight = newValue
                    }
                }
                
                VStack {
                    Button(exercise == nil ? "Add" : "Save") {
                        vm.name = nameText
                        vm.rep = Int(repsText) ?? 0
                        vm.sets = Int(setsText) ?? 0
                        vm.weight = Double(weightText) ?? 0
                        
                        vm.saveExercise(exercise) // if exercise exists, updates; else adds
                        
                        dismiss()
                    }
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding()
            .onAppear {
                // Fill fields if editing
                if let ex = exercise {
                    nameText = ex.name
                    repsText = "\(ex.reps)"
                    setsText = "\(ex.sets)"
                    weightText = "\(ex.weight)"
                    
                    // Also update VM
                    vm.name = ex.name
                    vm.rep = ex.reps
                    vm.sets = ex.sets
                    vm.weight = ex.weight
                }
            }
            .navigationTitle(exercise == nil ? "Add Exercise" : "Edit Exercise")
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, Workout.self, configurations: config)
    let context = ModelContext(container)

    
    NavigationStack {
        ExerciseFormView()
            .environment(\.modelContext, context)
            .environment(ExerciseViewModel(context: context))
    }
}
