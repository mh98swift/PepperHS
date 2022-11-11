//
//  Operation.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//

import Foundation

struct PepperOperation: Codable{
    let operationType: String
    let operationDesc: String?
    let amount: Double
    let source: String?
    let address: String?
    let operationId: Int
}
