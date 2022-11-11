//
//  OperationCell.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//

import UIKit

class OperationCell: UITableViewCell {
    
    @IBOutlet weak var operationType: UILabel!
    @IBOutlet weak var operationDesc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
