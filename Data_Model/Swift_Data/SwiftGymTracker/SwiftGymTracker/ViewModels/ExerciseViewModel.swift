//
//  ExerciseViewMode.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import Foundation
import SwiftData

@Observable
final class ExerciseViewModel: ModelContextInitializable {
    
    typealias ModelType = Exercise
    
    let context: ModelContext
    
    var items: [Exercise] = []
    
    var name: String = ""
    var rep: Int = 0
    var sets: Int = 0
    var weight: Double = 0.0
    
    
    // MARK: - Init
    @MainActor required init(context: ModelContext) {
        self.context = context
        load()
    }
    
    
    
    // MARK: - Load
    @MainActor
    func load() {
        do {
            let descriptor = FetchDescriptor<Exercise>(sortBy: [.init(\.name, order: .forward)])
            let results = try  context.fetch(descriptor)
            self.items = results
        }catch{
            print("❌ Failed to fetch Exercises:  \(error.localizedDescription)")
        }
    }
    
    // MARK: - CRUD
    
    // Create, Update
    func saveExercise(_ exercise: Exercise? = nil, workout: Workout? = nil) {
        if let exercise = exercise {
            // --- Update existing exercise ---
            exercise.name = name
            exercise.reps = rep
            exercise.sets = sets
            exercise.weight = weight
            
            if let index = items.firstIndex(where: { $0.id == exercise.id }) {
                items[index] = exercise
            }
        } else {
            // --- Add new exercise ---
            let newExercise = Exercise(
                name: name,
                reps: rep,
                sets: sets,
                weight: weight,
                workout: workout
            )
            context.insert(newExercise)
            items.append(newExercise)
        }
        save()

        name = ""
        rep = 0
        sets = 0
        weight = 0.0
    }
    // Delete
     func deleteExercise(_ exercise: Exercise) {
         context.delete(exercise)
         save()
         
         // Remove from local items array to update UI
         if let index = items.firstIndex(where: { $0.id == exercise.id }) {
             items.remove(at: index)
         }
     }
    
    
    // MARK: - Save Context
    private func save() {
        do {
            try context.save()
        } catch {
            print("❌ Failed to save Exercise: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Helper
    
    var totalVolume: Double {
        items.reduce(0) {$0 + Double($1.reps * $1.sets) * $1.weight}
    }
    
    
    var totalVolumeComputed: Double {
        Double(rep * sets) * weight
    }
}
