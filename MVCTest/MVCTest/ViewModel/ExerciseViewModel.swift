//
//  ExerciseViewModel.swift
//  MVCTest
//
//  Created by Ismet Meray on 06/03/2022.
//

import Foundation

class ExerciseViewModel: ObservableObject{
    @Published var error: AppError? = nil
    @Published var allExercises: [Exercise] = []
    @Published var selectedExercises : [Int] = []
    @Published var workout: Workout? = nil
    
    init(){
        getAllExercises()
        getNrOfWorkouts()
    }
    
    func getAllExercises(){
        localStorageHelper.getFile{
            (data) in
            data.forEach{
                exercise in
                self.allExercises.append(exercise)
            }
        }
    }
    
    func getNrOfWorkouts(){
        NetworkService.shared.getNrOfWorkoutsOfUser{
            (result)
            in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.workout = Workout(id: data, name: "workout \(data + 1)", userID: JWTHelper().decodeJWT().body["id"]! as! Int, createdAt: "2020-12-12", updateAt: "2020-12-12", workoutexercise: [])
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = AppError.serverError(error.localizedDescription)
                }
            }
        }
    }
    
    func addExercisesToWorkout(){
        print(allExercises.count)
        //        var workoutExercises: [WorkoutExercise] = []
        var i = 0
        for index in selectedExercises{
            let exercise = allExercises[index]
            self.workout?.workoutexercise.append(WorkoutExercise(exercise: exercise, exerciseData: [], order: i))
            i+=1
        }
        
        print(self.workout?.workoutexercise)
        getExerciseUserData(1)
    }
    
    func getExerciseUserData(_ exerciseId: Int){
        print(exerciseId)
        NetworkService.shared.getExerciseUserData(exerciseId){
            (result)
            in
            switch result{
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    for var we in self.workout?.workoutexercise ?? []{
                        if(exerciseId == we.exercise.id){
                            we.exerciseData = data
                        }
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
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
                self.error = AppError.serverError(error.localizedDescription)
            }
        }
    }
    
    func selectExercise(_ index: Int){
        selectedExercises.append(index)
    }
    
    func deselectExercise(_ index: Int){
        if let index = selectedExercises.firstIndex(of: index) {
            selectedExercises.remove(at: index)
        }
    }
}
