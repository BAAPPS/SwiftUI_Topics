//
//  Workout.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import Foundation
import SwiftData


@Model
final class Workout {
    @Attribute var id: UUID = UUID()
    var name: String = ""
    var date: Date = Date.now
    var duration: TimeInterval = 0
    var notes: String? = nil
    
    
    @Relationship(deleteRule: .cascade, inverse: \Exercise.workout) var exercises: [Exercise]?

    var safeExercises: [Exercise] { exercises ?? [] }
    
    var totalVolume: Double {
        safeExercises.reduce(0) { $0 + Double($1.reps * $1.sets) * $1.weight }
    }


    init(name: String, date: Date, duration: TimeInterval, notes: String?, exercises: [Exercise]) {
        self.name = name
        self.date = date
        self.duration = duration
        self.notes = notes
        self.exercises = exercises
    }
}
