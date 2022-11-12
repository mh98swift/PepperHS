//
//  FinancialOperationsTableVC.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//

import UIKit

typealias LoadOperationsFromLocalJson = (@escaping (Result<[PepperOperation], Error>) -> Void ) -> Void

class FinancialOperationsTableVC: UIViewController {
    
    //instead of calling the Api directly
    //ApiManager.shard.loadOperationsFromLocalJson
    //we make an init of the API just for this call by inject it
    
//    var api: ApiManager = .shard // Property injection
    
//    var api: ApiProtocol = ApiManager.shard // Property injection using Protocol
    
//    var loadOperationsFromLocalJson: LoadOperationsFromLocalJson =  ApiManager.shard.loadOperationsFromLocalJson // Property injection using Closure
    
    var loadOperationsFromLocalJson: LoadOperationsFromLocalJson = { completion in
        ApiManager.shard.loadOperationsFromLocalJson {result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }  // Property injection using Closure and thrting
    
    
    //with out storyboard // init injection
//    init(api: ApiManager){
//        self.api = api
//    }

//    private var pepperOperations: [PepperOperation] = []
    private var pepperOperations: [PepperOperationViewModel] = []


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Financial operations"
        
        configureTableView()
        getOperations()
    }
    
    
    private func getOperations(){
        loadOperationsFromLocalJson { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let pepperOperations):
                self.pepperOperations = pepperOperations.map(PepperOperationViewModel.init)
                    self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? OperationCellCash_Withdrawal
        
        let vm = pepperOperations[indexPath.row]
        
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

struct PepperOperationViewModel {
    let operationType: String
    let operationDesc: String?
    let amount: Double
    let source: String?
    let address: String?
    
    init(operation: PepperOperation){
        operationType = operation.operationType
//       if operationType == "CASH_WITHDRAWAL"
        // if operationType == "CASH_WITHDRAWAL"->(clickable) show CASH_WITHDRAWAL cell
        // if operationType == "CHARGE" -> (i clickable)show CHARGE cell
        // if operationType == "“SAVING_WITHDRAWAL” || “REFUND” || “SALARY” -> (i clickable) RECIVE Cell
        
        operationDesc = operation.operationType
        amount = operation.amount
        source = operation.source
        address = operation.address
    }
}

