//
//  FinancialOperationsTableVC.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//

import UIKit

class FinancialOperationsTableVC: UIViewController {

    var pepperOperations: [PepperOperation] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Financial operations"
        
        configureTableView()
        getOperations()
    }
    
    
    func getOperations(){
        ApiManager.shard.loadOperationsFromLocalJson { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let pepperOperations):
                DispatchQueue.main.async {
                    self.pepperOperations = pepperOperations
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FinancialOperationsTableVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pepperOperations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? OperationCell
        
        cell?.operationType.text = pepperOperations[indexPath.row].operationType
        cell?.operationDesc.text = pepperOperations[indexPath.row].operationDesc
        cell?.accessoryType = .detailButton
        
        if pepperOperations[indexPath.row].operationType.contains("CHARGE"){
            cell?.backgroundColor = .green
        }
        else if pepperOperations[indexPath.row].operationType.contains("REFUND"){
            cell?.backgroundColor = .systemCyan
        }
        else if pepperOperations[indexPath.row].operationType.contains("CASH"){
            cell?.backgroundColor = .systemPink
        }
        else if pepperOperations[indexPath.row].operationType.contains("SAVING"){
            cell?.backgroundColor = .systemMint
        }
        else{
            cell?.backgroundColor = .white
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}

