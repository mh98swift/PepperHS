//
//  User.swift
//  EDeveloperMVC
//
//  Created by MiciH on 7/19/21.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

struct UserData: Codable{
    let operationType: String
    let operationDesc: String?
    let amount: Double
    let source: String?
    let address: String?
    let operationId: Int
}


//struct Operations: Decodable {
//    let operationsArray: [Operation]
//}
//
//
//struct Operation: Decodable {
//    let operationType: String
//    let operationDesc: String?
//    let amount: Double
//    let source: String?
//    let address: String
//    let operationId: Int
//    
//}
