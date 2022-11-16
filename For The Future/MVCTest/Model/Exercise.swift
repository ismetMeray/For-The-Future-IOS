//
//  Exercise.swift
//  MVCTest
//
//  Created by Ismet Meray on 22/02/2022.
//

import Foundation

struct Exercise: Codable, Identifiable, Hashable{
    
    let id: Int
    let name: String
    let gifURL: String
    let updateAt, createdAt: String
    let bodyPart, equipment, muscleTarget: BodyPart?

    enum CodingKeys: String, CodingKey {
        case id, name
        case gifURL = "gifUrl"
        case updateAt, createdAt, bodyPart, equipment, muscleTarget
    }
    
}
