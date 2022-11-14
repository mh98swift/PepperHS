//
//  ChargeCell.swift
//  PepperHS
//
//  Created by VCM1 on 12/11/2022.
//

import UIKit

protocol ChargeCellDelegateCell {
    func iChargeButtonTapped(id: Int)
}

class ChargeCell: UITableViewCell {
    
    @IBOutlet var amount: UILabel!
    @IBOutlet var operationDesc: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "ChargeCell", bundle: nil)
    }
    
    var delegate: ChargeCellDelegateCell?
    var operation: PepperOperationViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
    func config(operation: PepperOperationViewModel){
        self.operation = operation
        amount.text = operation.getAmountToDollarString()
        operationDesc.text = operation.operationDesc
    }
    
    @IBAction func iChargeTapped(_ sender: UIButton) {
        guard let operationId = operation?.operationId else { return }
        delegate?.iChargeButtonTapped(id: operationId)
    }
    
}
