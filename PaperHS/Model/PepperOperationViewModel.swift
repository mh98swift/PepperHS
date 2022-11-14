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
        operationDesc = operation.operationDesc
        amount = operation.amount
        
        source = operation.source
        address = operation.address
        operationId = operation.operationId
    }
    
    func getAmountToDollarString(decimalPoint: Int = 0)-> String{
        return String(format: "$"+"%.\(decimalPoint)f", amount)
    }
    
    func cellDataToSearch(searchText: String) -> Bool{
        /*
    operationType: String
    operationDesc: String?
    amount: Double
    source: String?
    address: String?
    operationId: Int
         
        */
        
        
        let searchTextLower = searchText.lowercased()
        let desc = operationDesc?.lowercased() ?? ""
        let source = source?.lowercased() ?? ""
        let address = address?.lowercased() ?? ""
        let amount = String(amount.rounded(.up))
        if operationType.lowercased().contains(searchTextLower) ||
            desc.contains(searchTextLower) ||
            source.contains(searchTextLower) ||
            address.contains(searchTextLower) ||
            amount.contains(searchTextLower)
        {
            return true
        }
        
       
        return false
    }
}


