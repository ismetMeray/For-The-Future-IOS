//
//  ApiResponse.swift
//  MVCTest
//
//  Created by Ismet Meray on 27/01/2022.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable{

    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
