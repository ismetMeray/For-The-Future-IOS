//
//  MVCTestApp.swift
//  MVCTest
//
//  Created by Ismet Meray on 22/01/2022.
//

import SwiftUI

var localStorageHelper = LocalStorageHelper()

class AppState : ObservableObject{
    @Published var isAuthenticated: Bool
    var defaults = UserDefaults.standard
    
    init(){
        defaults.set("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQ2NTc3MDYxfQ.xK0Lk_YMaXx7pnARBtqi8PPL93KMbZApO99a9LHTCJw", forKey: "jsonwebtoken")
        
        if(defaults.string(forKey: "jsonwebtoken") == ""){
            self.isAuthenticated = false
        }else{
            self.isAuthenticated = true
        }
    }
    
    init(auth: Bool){
        self.isAuthenticated = auth
    }
}

@main
struct ForTheFuture: App {
    @ObservedObject var appState: AppState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if(!appState.isAuthenticated){
                let loginVM: LoginViewModel = LoginViewModel(appState)
                ContentView().environmentObject(loginVM)
            }else{
                let homeVM: HomePageViewModel = HomePageViewModel(appState)
                HomePage().environmentObject(homeVM)
            }
        }
    }
}
