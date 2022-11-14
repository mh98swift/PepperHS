//
//  SavingRefundSalayCell.swift
//  PepperHS
//
//  Created by VCM1 on 13/11/2022.
//

import UIKit

protocol SavingRefundSalaryDelegate {
    func buttonTapped(id: Int)
}

class SavingRefundSalaryCell: UITableViewCell {

    @IBOutlet var amount: UILabel!
    @IBOutlet var receivePayment: UILabel!
    @IBOutlet var iButton: UIButton!
    
    static func nib() -> UINib {
        return UINib(nibName: "SavingRefundSalayCell", bundle: nil)
    }
    var delegate: SavingRefundSalaryDelegate?
    var operation: PepperOperationViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func config(operation: PepperOperationViewModel){
        self.operation = operation
        amount.text = operation.getAmountToDollarString(decimalPoint: 1)
        receivePayment.text = "Received Payment"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let operationId = operation?.operationId else { return }
        delegate?.buttonTapped(id: operationId)
    }
}
