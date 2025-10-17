//
//  Exercise.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import Foundation
import SwiftData

@Model
final class Exercise {
    @Attribute var id: UUID = UUID()
    var name: String = ""
    var reps: Int = 0
    var sets: Int = 0
    var weight: Double = 0.0
    
    @Relationship var workout: Workout?

    
    init(name: String, reps: Int, sets: Int, weight: Double, workout: Workout? = nil) {
        self.name = name
        self.reps = reps
        self.sets = sets
        self.weight = weight
        self.workout = workout
    }
}
