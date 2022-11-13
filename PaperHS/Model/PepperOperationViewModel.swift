//
//  PepperOperationViewModel.swift
//  PepperHS
//
//  Created by VCM1 on 12/11/2022.
//

import Foundation

struct PepperOperationViewModel {
    let operationType: String
    let operationDesc: String?
    let amount: Double
    let source: String?
    let address: String?
    let operationId: Int
    
    init(operation: PepperOperation){
        operationType = operation.operationType
//       if operationType == "CASH_WITHDRAWAL"
        // if operationType == "CASH_WITHDRAWAL"->(clickable) show CASH_WITHDRAWAL cell
        // if operationType == "CHARGE" -> (i clickable)show CHARGE cell
        // if operationType == "“SAVING_WITHDRAWAL” || “REFUND” || “SALARY” -> (i clickable) RECIVE Cell
        
        operationDesc = operation.operationType
        amount = operation.amount
        source = operation.source
        address = operation.address
        operationId = operation.operationId
    }
}
