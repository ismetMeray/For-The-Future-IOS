//
//  NetworkService.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/04/2021.
//

import Foundation
import JWTDecode

struct NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func login(account: Account, completion: @escaping(Result<String, AppError>) -> Void){
        let params = ["username": account.userName, "password": account.passWord]
        
        request(route: .login, method: .post, parameters: params, completion: completion)
    }
    
    func getAllWorkoutsOfUser(completion: @escaping(Result<[Workout], AppError>) -> Void){
        
        request(route: .getAllWorkoutOfUser(1) , method: .get, completion: completion)
    }
    
    func getAllExercises(completion: @escaping(Result<[Exercise], AppError>) -> Void){
        
        request(route: .getAllExercises , method: .get, completion: completion)
    }
    
    func getNrOfWorkoutsOfUser(completion: @escaping(Result<Int, AppError>) -> Void){
    
        request(route: .getNrOfWorkouts(1) , method: .get, completion: completion)
    }
    
    func getExerciseUserData(_ exerciseId: Int, completion: @escaping(Result<[ExerciseData], AppError>) -> Void){
        
        request(route: .getExerciseUserData(1, exerciseId) , method: .get, completion: completion)
    }
    
    func addExercisesToWorkout(_ exercisesToAdd: [WorkoutExercise], _ workoutId: Int, completion: @escaping(Result<Int, AppError>) -> Void){

        let package = createDataPackage(data: exercisesToAdd, packageName: "exercisestoadd")
        
        request(route: .addExercisesToWorkout(1, workoutId) , method: .post, parameters: package, completion: completion)
    }
    
    func saveWorkoutRoutine(_ workoutRoutine: Workout, completion: @escaping(Result<Int, AppError>) -> Void){
        var stringData = String()
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(workoutRoutine)
        stringData = String(data: encodedData, encoding: .utf8) ?? ""
        let package : [String : Any] = ["workout" : stringData]
        request(route: .saveWorkoutRoutine(1, workoutRoutine.id), method: .post, parameters: package, completion: completion)
    }
    
    
    
    private func request<T: Decodable>(route: Route,
                                       method: Method,
                                       parameters: [String: Any]? = nil,
                                       completion: @escaping(Result<T, AppError>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, AppError>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
            } else if let error = error {
                result = .failure(AppError.errorDecoding)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, AppError>?,
                                              completion: (Result<T, AppError>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let dataString = String(data: data, encoding: .utf8)
            let jsonData = (dataString?.data(using: .utf8))!
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: jsonData) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    /// This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: the path the the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = url(route: route)
//        print(urlString)
        var urlRequest = URLRequest(url: urlString)
        print(urlRequest)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")  ?? ""
        
        if(token != ""){
            urlRequest.addValue(token, forHTTPHeaderField: "authorization")
        }
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString.absoluteString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}

func createDataPackage<T: Codable>(data: T, packageName: String) -> [String: Any]{
    var stringData = String()
    let encoder = JSONEncoder()
    let encodedData = try! encoder.encode(data)
    stringData = String(data: encodedData, encoding: .utf8) ?? ""
    let package : [String : Any] = [packageName : stringData]
    return package
}

