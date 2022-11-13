//
//  ApiManager.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//


import Foundation

//protocol ApiProtocol {
//    func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void )
//}

class ApiManager {
    
    static let shard = ApiManager()
    private init() {}
    
    var pepperOperations: PepperOperations?
//    @Published var pepperOperations = [PepperOperation]()
    
    func loadOperationsFromLocalJson(completion: @escaping (Result<[PepperOperation], Error>) -> Void ) {
            
            if let fileLocation = Bundle.main.url(forResource: "mydata", withExtension: "json") {
                
                // do catch in case of an error
                do {
                    let data = try Data(contentsOf: fileLocation)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode(PepperOperations.self, from: data)
                    
                    self.pepperOperations = dataFromJson
                    print(pepperOperations?.operations)
                    completion(.success(pepperOperations?.operations ?? []))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    
}

