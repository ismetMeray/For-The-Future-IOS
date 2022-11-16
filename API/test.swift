// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let workout = try? newJSONDecoder().decode(Workout.self, from: jsonData)

import Foundation

// MARK: - Workout
struct Workout: Codable {
    let data: [Workout]
}

// MARK: - Datum
struct Workout: Codable {
    let id: Int
    let name: String
    let userID: Int
    let createdAt, updateAt: String
    let workoutexercise: [Workoutexercise]

    enum CodingKeys: String, CodingKey {
        case id, name
        case userID = "userId"
        case createdAt, updateAt, workoutexercise
    }
}

// MARK: - Workoutexercise
struct Workoutexercise: Codable {
    let exercise: Exercise
    let order: Int
}

// MARK: - Exercise
struct Exercise: Codable {
    let id: Int
    let name: String
    let gifURL: String
    let updateAt, createdAt: String
    let bodyPart, equipment, muscleTarget: BodyPart

    enum CodingKeys: String, CodingKey {
        case id, name
        case gifURL = "gifUrl"
        case updateAt, createdAt, bodyPart, equipment, muscleTarget
    }
}

// MARK: - BodyPart
struct BodyPart: Codable {
    let id: Int
    let name: String
}
