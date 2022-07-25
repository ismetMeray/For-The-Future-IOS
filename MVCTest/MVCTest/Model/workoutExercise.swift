//
//  workoutExercise.swift
//  MVCTest
//
//  Created by Ismet Meray on 23/02/2022.
//

import Foundation

struct WorkoutExercise: Codable, Hashable{
    
    var exercise: Exercise
    var exerciseData: [ExerciseData]
    var order: Int
    
    static func ==(lhs: WorkoutExercise, rhs: WorkoutExercise) -> Bool {
        return lhs.exercise.id == rhs.exercise.id
    }
}
