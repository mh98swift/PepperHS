//
//  SavingRefundSalayCell.swift
//  PepperHS
//
//  Created by VCM1 on 13/11/2022.
//

import UIKit

class SavingRefundSalaryCell: UITableViewCell {

    @IBOutlet var amount: UILabel!
    @IBOutlet var receivePayment: UILabel!
    @IBOutlet var iButton: UIButton!
    static func nib() -> UINib {
        return UINib(nibName: "SavingRefundSalayCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(operation: PepperOperationViewModel){
        //pass text to UILabel
        amount.text = String(format: "$"+"%.1f", operation.amount)
        receivePayment.text = "Received Payment"
    }
    
}
