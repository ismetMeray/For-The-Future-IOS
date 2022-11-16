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
                    print(data + 1)
                    let nrOfWorkouts = data + 1
                    
                    self.workout = Workout(id: nrOfWorkouts, name: "workout \(nrOfWorkouts)", userID: JWTHelper().decodeJWT().body["id"]! as! Int, createdAt: "2020-12-12", updateAt: "2020-12-12", workoutexercise: [])
                    self.saveWorkoutRoutine()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = AppError.serverError(error.localizedDescription)
                }
            }
        }
    }
    
    func addExercisesToWorkout(){
        var workoutExercises: [WorkoutExercise] = []
        var i = 0
        for index in selectedExercises{
            let exercise = allExercises[index]
            workoutExercises.append(WorkoutExercise(exercise: exercise, exerciseData: [], order: i))
            i+=1
        }
        
        NetworkService.shared.addExercisesToWorkout(workoutExercises, self.workout!.id){
            (result)
            in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                    self.getExerciseUserData(1)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = AppError.serverError(error.localizedDescription)
                }
            }
        }
        
    }
    
    func saveWorkoutRoutine(){
        
        NetworkService.shared.saveWorkoutRoutine(self.workout!){
            (result)
            in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                }
            case.failure(let error):
                print(error)
                self.error = AppError.serverError(error.localizedDescription)
            }
        }
    }
    
    func getExerciseUserData(_ exerciseId: Int){
        NetworkService.shared.getExerciseUserData(exerciseId){
            (result)
            in
            switch result{
            case .success(let data):
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
