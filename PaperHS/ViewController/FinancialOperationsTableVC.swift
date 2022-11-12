//
//  FinancialOperationsTableVC.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//

import UIKit

class FinancialOperationsTableVC: UIViewController {
    
    //instead of calling the Api directly
    //ApiManager.shard.loadOperationsFromLocalJson
    //we make an init of the API just for this call by inject it
    var api: ApiManager = .shard // Property injection
    
    //with out storyboard // init injection
//    init(api: ApiManager){
//        self.api = api
//    }

    private var pepperOperations: [PepperOperation] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Financial operations"
        
        configureTableView()
        getOperations()
    }
    
    
    private func getOperations(){
        api.loadOperationsFromLocalJson { (result) in
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
    
    private func configureTableView(){
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
        
        let vm = pepperOperationViewModel(operation: pepperOperations[indexPath.row])
        
        cell?.operationType.text = vm.operationType
        cell?.operationDesc.text = vm.operationDesc
        cell?.accessoryType = .detailButton
        
        if vm.operationType.contains("CHARGE"){
            cell?.backgroundColor = .green
        }
        else if vm.operationType.contains("REFUND"){
            cell?.backgroundColor = .systemCyan
        }
        else if vm.operationType.contains("CASH"){
            cell?.backgroundColor = .systemPink
        }
        else if vm.operationType.contains("SAVING"){
            cell?.backgroundColor = .systemMint
        }
        else{
            cell?.backgroundColor = .white
        }
        
        return cell ?? UITableViewCell()
    }
}

struct pepperOperationViewModel {
    let operationType: String
    let operationDesc: String?
    let amount: Double
    let source: String?
    let address: String?
    
    init(operation: PepperOperation){
        operationType = operation.operationType
        // if operationType == "CASH_WITHDRAWAL"->(clickable) show CASH_WITHDRAWAL cell
        // if operationType == "CHARGE" -> (i clickable)show CHARGE cell
        // if operationType == "“SAVING_WITHDRAWAL” || “REFUND” || “SALARY” -> (i clickable) RECIVE Cell
        
        operationDesc = operation.operationType
        amount = operation.amount
        source = operation.source
        address = operation.address
    }
}

