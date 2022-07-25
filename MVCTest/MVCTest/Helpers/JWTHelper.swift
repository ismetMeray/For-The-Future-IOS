//
//  JWTHelper.swift
//  MVCTest
//
//  Created by Ismet Meray on 02/05/2022.
//

import Foundation
import JWTDecode

struct JWTHelper{
    
    func decodeJWT() -> JWT{
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        let payload = try? JWTDecode.decode(jwt: token)
        
        return payload!
    }
}
