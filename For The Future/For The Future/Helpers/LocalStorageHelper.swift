//
//  LocalStorageHelper.swift
//  MVCTest
//
//  Created by Ismet Meray on 08/03/2022.
//

import Foundation

struct LocalStorageHelper{
    
    var fileName: String = "exercises.json"
    var exercises: [Exercise] = []
    
    func saveToFile() -> Bool{
        guard let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return false}
        
        let outputURL = docDirectoryURL.appendingPathComponent(fileName)
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonCodedData = try jsonEncoder.encode(exercises)
            try jsonCodedData.write(to: outputURL)
        } catch {
            print("Failed to write to file \(error.localizedDescription)")
            return false
        }
        
        print("Wrote to \(fileName)")
        return true
    }
    
    
    func getFile(completion: @escaping(_ data: [Exercise]) -> ()){
        
        DispatchQueue.global(qos: .background).async{
            
            let fileManager = FileManager.default
            
            guard let docDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return}
            
            let inputFileURL = docDirectoryURL.appendingPathComponent(fileName)
            
            guard fileManager.fileExists(atPath: inputFileURL.path)
            else {
                print("File Doesn't exist. Try typing a name and hitting 'Save' First.")
                return
            }
            
            do {
                let inputData = try Data(contentsOf: inputFileURL)
                let decoder = JSONDecoder()
                let decodedString = try decoder.decode([Exercise].self, from: inputData)
                DispatchQueue.main.async {
                    completion(decodedString)
                }
            } catch {
                print("Failed to open file contents for display!")
                return
            }
        }
    }
}
