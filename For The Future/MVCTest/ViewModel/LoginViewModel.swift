//
//  LoginViewModel.swift
//  MVCTest
//
//  Created by Ismet Meray on 22/01/2022.
//

import SwiftUI

class LoginViewModel : ObservableObject{
    
    var userName: String = ""
    var password: String = ""
    @Published var appState: AppState
    @Published var error: AppError?
    
    public init(_ appState: AppState){
        self.appState = appState
    }
    
    public func login(userName: String, passWord: String){
        let account: Account = Account(userName: userName, passWord: passWord)
        
        NetworkService.shared.login(account: account){
            (result)
            in
            let defaults = UserDefaults.standard
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    print("first")
                    defaults.set(data, forKey: "jsonwebtoken")
                    self.appState.isAuthenticated = true
                }
            case.failure(let error):
                self.error = error
            }
        }
    }
}
