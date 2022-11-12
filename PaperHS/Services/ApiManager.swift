//
//  ApiManager.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//


import Foundation

protocol Api {
    func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void )
}

class ApiManager: Api {
    
    static let shard = ApiManager()
    
    private init() {}
    
    @Published var pepperOperations = [PepperOperation]()
    
    func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void ) {
            
            if let fileLocation = Bundle.main.url(forResource: "mydata", withExtension: "json") {
                
                // do catch in case of an error
                do {
                    let data = try Data(contentsOf: fileLocation)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode([PepperOperation].self, from: data)
                    
                    self.pepperOperations = dataFromJson
                    print(pepperOperations)
                    completion(.success(pepperOperations))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    
}

