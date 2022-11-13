//
//  ChargeCell.swift
//  PepperHS
//
//  Created by VCM1 on 12/11/2022.
//

import UIKit

class ChargeCell: UITableViewCell {
    
    @IBOutlet var amount: UILabel!
    @IBOutlet var operationDesc: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "ChargeCell", bundle: nil)
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
        amount.text = String(format: "$"+"%.0f", operation.amount)
        operationDesc.text = operation.operationDesc
    }
    
}
