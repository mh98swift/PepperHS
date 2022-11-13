//
//  FinancialOperationsTableVC.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//

import UIKit

typealias LoadOperationsFromLocalJson = (@escaping (Result<[PepperOperation], Error>) -> Void ) -> Void

class FinancialOperationsTableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
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
    private var filteredPepperOperations: [PepperOperationViewModel] = []
    


   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Financial operations"
        
        configureTableView()
        searchBar.delegate = self
        getOperations()
    }
    
    
    private func getOperations(){
        loadOperationsFromLocalJson { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let pepperOperations):
                self.pepperOperations = pepperOperations.map(PepperOperationViewModel.init)
//                self.pepperOperations = self.pepperOperations

                    self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChargeCell.nib(), forCellReuseIdentifier: "ChargeCell")
        tableView.register(CashWithDrawalCell.nib(), forCellReuseIdentifier: "CashWithDrawalCell")
        tableView.register(SavingRefundSalaryCell.nib(), forCellReuseIdentifier: "SavingRefundSalaryCell")
        
    }
}

extension FinancialOperationsTableVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pepperOperations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? OperationCellCash_Withdrawal
        
//        var cellType: UITableViewCell?
        
        
        
        
        let vm = pepperOperations[indexPath.row]
        
//        cell?.operationType.text = vm.operationType
//        cell?.operationDesc.text = vm.operationDesc
        
        
        
        
        if vm.operationType == "CHARGE" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ChargeCell", for: indexPath) as? ChargeCell {
                cell.config(operation: vm)
                return cell
            }
            //show x y z
        }
        else if vm.operationType == "CASH_WITHDRAWAL" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CashWithDrawalCell", for: indexPath) as? CashWithDrawalCell {
                cell.config(operation: vm)
            return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SavingRefundSalaryCell", for: indexPath) as? SavingRefundSalaryCell{
                cell.config(operation: vm)
                self.tableView.rowHeight = 100.0
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailIDVC") as? DetailIDVC{
            
            let vm = pepperOperations[indexPath.row]
            
            vc.operationID = String(vm.operationId)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FinancialOperationsTableVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let filter = searchBar.text, !filter.isEmpty else {return}
        
//        filteredPepperOperations = pepperOperations.filter{$0.operationType.lowercased().contains(filter.lowercased())}
        
//        if searchText == "" {
//            filteredPepperOperations = pepperOperations
//        }
//        else{
//            for opr in pepperOperations {
//                if opr.operationType.lowercased().contains(searchText.lowercased()){
//                    filteredPepperOperations.append(opr)
//                }
//            }
//        }
        
        tableView.reloadData()
    }
}



