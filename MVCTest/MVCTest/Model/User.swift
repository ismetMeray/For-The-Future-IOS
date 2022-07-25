//
//  User.swift
//  MVCTest
//
//  Created by Ismet Meray on 22/01/2022.
//

import Foundation

struct User: Codable, Identifiable{
    
    var id: Int?
    var username: String = ""
    var email: String = ""
    var workOuts: [Workout] = []    
}
