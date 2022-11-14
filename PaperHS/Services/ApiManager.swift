//
//  ApiManager.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//


import Foundation

class ApiManager {
    
    static let shard = ApiManager()
    private init() {}
    
    var pepperOperations: PepperOperations?
    
    func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void ) {
        
        if let fileLocation = Bundle.main.url(forResource: "mydata", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(PepperOperations.self, from: data)
                
                self.pepperOperations = dataFromJson
                completion(.success(pepperOperations?.operations ?? []))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
}

