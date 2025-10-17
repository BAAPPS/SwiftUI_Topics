//
//  WorkoutViewModel.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import Foundation
import SwiftData

@Observable
final class WorkoutViewModel: ModelContextInitializable {

    typealias ModelType = Workout
    
    let context: ModelContext
    
    var items: [Workout] = []
    
    // Properties for creating/updating a workout
    var name: String = ""
    var date: Date = Date()
    var duration: TimeInterval = 0
    var notes: String = ""
    var exercises: [Exercise] = []

    // MARK: - Init
    @MainActor required init(context: ModelContext) {
        self.context = context
        load()
    }
    
    // MARK: - Load
    @MainActor
    func load() {
        do {
            let descriptor = FetchDescriptor<Workout>(sortBy: [.init(\.date, order: .forward)])
            let results = try context.fetch(descriptor)
            self.items = results
        } catch {
            print("❌ Failed to fetch Workouts: \(error.localizedDescription)")
        }
    }
    
    // MARK: - CRUD
    func saveWorkout(_ workout: Workout? = nil) {
        if let workout = workout {
            // Update existing workout
            workout.name = name
            workout.date = date
            workout.duration = duration
            workout.notes = notes
            workout.exercises = exercises
            
            if let index = items.firstIndex(where: { $0.id == workout.id }) {
                items[index] = workout
            }
        } else {
            // Add new workout
            let newWorkout = Workout(
                name: name,
                date: date,
                duration: duration,
                notes: notes.isEmpty ? nil : notes,
                exercises: exercises
            )
            context.insert(newWorkout)
            items.append(newWorkout)
        }
        save()
        
        // Reset fields
        name = ""
        date = Date()
        duration = 0
        notes = ""
        exercises = []
    }
    
    func deleteWorkout(_ workout: Workout) {
        context.delete(workout)
        save()
        if let index = items.firstIndex(where: { $0.id == workout.id }) {
            items.remove(at: index)
        }
    }
    
    // MARK: - Save Context
    private func save() {
        do {
            try context.save()
        } catch {
            print("❌ Failed to save Workout: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Helper
    var totalVolume: Double {
        items.reduce(0) { total, workout in
            total + workout.safeExercises.reduce(0) { $0 + Double($1.reps * $1.sets) * $1.weight }
        }
    }
}
