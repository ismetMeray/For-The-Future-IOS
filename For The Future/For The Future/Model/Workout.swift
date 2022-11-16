//
//  Workout.swift
//  MVCTest
//
//  Created by Ismet Meray on 22/02/2022.
//

import Foundation

struct Workout: Codable, Identifiable{
    
    var id: Int
    var name: String
    var userID: Int
    var createdAt, updateAt: String
    var workoutexercise: [WorkoutExercise]

        enum CodingKeys: String, CodingKey {
            case id, name
            case userID = "userId"
            case createdAt, updateAt, workoutexercise
        }
}
