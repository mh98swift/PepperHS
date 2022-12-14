//
//  CashWithDrawalCell.swift
//  PepperHS
//
//  Created by VCM1 on 13/11/2022.
//

import UIKit

class CashWithDrawalCell: UITableViewCell {

    @IBOutlet var amount: UILabel!
    @IBOutlet var source: UILabel!
    @IBOutlet var address: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "CashWithDrawalCell", bundle: nil)
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
        source.text = operation.source
        address.text = operation.address
    }
    
}
