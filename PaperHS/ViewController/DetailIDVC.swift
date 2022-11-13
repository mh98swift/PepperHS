//
//  DetailIDVC.swift
//  PepperHS
//
//  Created by VCM1 on 13/11/2022.
//

import UIKit

class DetailIDVC: UIViewController {

    @IBOutlet var operationIDLabel: UILabel!

    var operationID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Operations"
        
        operationIDLabel.text = operationID
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
