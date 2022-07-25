//
//  ExerciseData.swift
//  MVCTest
//
//  Created by Ismet Meray on 23/02/2022.
//

import Foundation

struct ExerciseData: Codable, Hashable{
    var id, exerciseID, workoutID, userID: Int
    var repetitions, weight: Int
    var createdAt, updateAt: String

    enum CodingKeys: String, CodingKey {
        case id 
        case exerciseID = "exerciseId"
        case workoutID = "workoutId"
        case userID = "userId"
        case repetitions, weight, createdAt, updateAt
    }
}
