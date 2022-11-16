//
//  ApiManager.swift
//  MVCTest
//
//  Created by Ismet Meray on 24/01/2022.
//

import Foundation

extension URLSession{
    
    enum CustomError: Error{
        case invalidUrl
        case invalidData
    }
    func request <T: Codable> (urlString: String, excpecting: T.Type, completion: @escaping (Result<T, Error>) -> Void){
        let baseURL: String = ProcessInfo.processInfo.environment["BASE_URL_LOCAL"]!
        let url: URL? = URL(string: baseURL + urlString)
        
        guard let url = url else{
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = dataTask(with: url) { data, _, error in
            guard let data = data else{
                if let error = error{
                    completion(.failure(error))
                }else{
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do{
                let result = try JSONDecoder().decode(excpecting, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
