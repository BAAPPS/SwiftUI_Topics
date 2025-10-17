//
//  WorkoutFormView.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI
import SwiftData

struct WorkoutFormView: View {
    @Environment(WorkoutViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    @Environment(ExerciseViewModel.self) var exVm
    
    let workout: Workout?
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var duration: Double = 0
    @State private var notes: String = ""
    @State private var selectedExercises: [Exercise] = []
    
    init(workout: Workout? = nil) {
        self.workout = workout
    }
    
    var body: some View {
        @Bindable var vm = vm
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - Workout Name
                TextField("Workout Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                // MARK: - Date Picker
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                
                // MARK: - Duration Slider
                VStack {
                    HStack {
                        Text("Duration (minutes)")
                        Spacer()
                        Text("\(Int(duration)) min")
                            .bold()
                    }
                    Slider(value: $duration, in: 0...300, step: 5)
                }
                
                // MARK: - Notes
                TextField("Notes", text: $notes)
                    .textFieldStyle(.roundedBorder)
                
                // MARK: - Select Exercises
                Text("Select Exercises")
                    .font(.headline)
                
                VStack(spacing: 10) {
                    ForEach(exVm.items) { exercise in
                        HStack {
                            Text(exercise.name)
                                .fontWeight(.medium)
                            Spacer()
                            if selectedExercises.contains(where: { $0.id == exercise.id }) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedExercises.contains(where: { $0.id == exercise.id }) ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleSelection(for: exercise)
                        }
                    }
                }
                
                // MARK: - Save Button
                Button(workout == nil ? "Add Workout" : "Save Workout") {
                    vm.name = name
                    vm.date = date
                    vm.duration = duration * 60 // minutes → seconds
                    vm.notes = notes
                    vm.exercises = selectedExercises
                    
                    vm.saveWorkout(workout)
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                
            }
            .padding()
            .onAppear {
                loadWorkoutData()
            }
        }
        .navigationTitle(workout == nil ? "Add Workout" : "Edit Workout")
    }
    
    // MARK: - Helpers
    private func toggleSelection(for exercise: Exercise) {
        if let index = selectedExercises.firstIndex(where: { $0.id == exercise.id }) {
            selectedExercises.remove(at: index)
        } else {
            selectedExercises.append(exercise)
        }
    }
    
    private func loadWorkoutData() {
        guard let w = workout else { return }
        name = w.name
        date = w.date
        duration = w.duration / 60
        notes = w.notes ?? ""
        selectedExercises = w.safeExercises
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, Workout.self, configurations: config)
    let context = ModelContext(container)

    // Seed exercises
    let bench = Exercise(name: "Bench Press", reps: 10, sets: 3, weight: 100)
    let pushups = Exercise(name: "Push-Ups", reps: 15, sets: 3, weight: 0)
    context.insert(bench)
    context.insert(pushups)

    let workoutVM = WorkoutViewModel(context: context)
    let exerciseVM = ExerciseViewModel(context: context)

    return NavigationStack {
        WorkoutFormView()
            .environment(\.modelContext, context)
            .environment(workoutVM)
            .environment(exerciseVM)
    }
}
