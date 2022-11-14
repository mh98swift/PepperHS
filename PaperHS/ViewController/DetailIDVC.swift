//
//  DetailIDVC.swift
//  PepperHS
//
//  Created by VCM1 on 13/11/2022.
//

import UIKit

class DetailIDVC: UIViewController {
    
    @IBOutlet var operationIDLabel: UILabel!
    
    static let identifier = "DetailIDVC"
    var operationID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Operations"
        
        operationIDLabel.text = operationID
    }
    
    
}
