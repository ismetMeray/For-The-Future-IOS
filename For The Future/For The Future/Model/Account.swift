//
//  Account.swift
//  MVCTest
//
//  Created by Ismet Meray on 22/01/2022.
//

import Foundation

struct Account: Codable{
    private(set) var userName: String = ""
    private(set) var passWord: String = ""
    private(set) var accountHolder: User?
    
    init(){
        
    }
    
    init(userName: String, passWord: String){
        self.userName = userName
        self.passWord = passWord
    }
    
    public func setAccountHolder(user: User){
        
    }
}
