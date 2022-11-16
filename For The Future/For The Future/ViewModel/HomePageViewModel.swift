//
//  HomePageViewModel.swift
//  MVCTest
//
//  Created by Ismet Meray on 03/02/2022.
//

import Foundation
import SwiftUI


class HomePageViewModel: ObservableObject{
    
    @Published var error: AppError?
    @Published var user: User = User()
    @Published var appState: AppState
    
    init(_ appState:AppState){
        self.appState = appState
        getUserData()
        loadInAllExercises()
    }
    
    init(){
        UserDefaults.standard.set("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQ2NDY3Nzk5fQ.sHYslm9ORLmgY-Y2JAkpIe8MYZuLWdHTME2hzcq-sBU", forKey: "jsonwebtoken")

        self.appState = AppState(auth: true)
        getUserData()
        loadInAllExercises()
    }
    
    func getUserData(){
        NetworkService.shared.getAllWorkoutsOfUser{
            (result)
            in
            switch result{
                case .success(let data):
                DispatchQueue.main.async {
                    self.user.workOuts = data
                }
            case.failure(let error):
                self.error = AppError.serverError(error.localizedDescription)
            }
        }
    }
    
    func loadInAllExercises(){
        NetworkService.shared.getAllExercises{
            (result)
            in
            switch result{
                case .success(let data):
                DispatchQueue.main.async {
                    localStorageHelper.exercises = data
                    if(!localStorageHelper.saveToFile()){
                        print("false")
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
//                self.appState.isAuthenticated = false
                self.error = AppError.serverError(error.localizedDescription)
            }
        }
    }
}
