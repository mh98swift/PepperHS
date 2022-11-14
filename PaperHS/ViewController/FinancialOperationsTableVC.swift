//
//  FinancialOperationsTableVC.swift
//  PepperHS
//
//  Created by VCM1 on 11/11/2022.
//

import UIKit

enum OperationType: String{
    case CHARGE = "CHARGE"
    case CASH_WITHDRAWAL = "CASH_WITHDRAWAL"
}

typealias LoadOperationsFromLocalJson = (@escaping (Result<[PepperOperation], Error>) -> Void ) -> Void

class FinancialOperationsTableVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let screenTitle = "Financial operations"
    
    var loadOperationsFromLocalJson: LoadOperationsFromLocalJson = { completion in
        ApiManager.shard.loadOperationsFromLocalJson {result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private var pepperOperations: [PepperOperationViewModel] = []
    private var filteredPepperOperations: [PepperOperationViewModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = screenTitle
        getOperations()
        configureTableView()
        searchBar.delegate = self
    }
    
    private func getOperations(){
        loadOperationsFromLocalJson { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let pepperOperations):
                self.pepperOperations = pepperOperations.map(PepperOperationViewModel.init)
                self.filteredPepperOperations = self.pepperOperations
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChargeCell.nib(), forCellReuseIdentifier: ChargeCell.identifier)
        tableView.register(CashWithDrawalCell.nib(), forCellReuseIdentifier: CashWithDrawalCell.identifier)
        tableView.register(SavingRefundSalaryCell.nib(), forCellReuseIdentifier: SavingRefundSalaryCell.identifier)
    }
}

extension FinancialOperationsTableVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPepperOperations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = filteredPepperOperations[indexPath.row]
        
        if vm.operationType == OperationType.CHARGE.rawValue {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ChargeCell.identifier, for: indexPath) as? ChargeCell {
                cell.config(operation: vm)
                cell.delegate = self
                return cell
            }
        }
        else if vm.operationType == OperationType.CASH_WITHDRAWAL.rawValue {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CashWithDrawalCell.identifier, for: indexPath) as? CashWithDrawalCell {
                cell.config(operation: vm)
                return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SavingRefundSalaryCell.identifier, for: indexPath) as? SavingRefundSalaryCell{
                cell.config(operation: vm)
                cell.delegate = self
                self.tableView.rowHeight = 100.0
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredPepperOperations[indexPath.row].operationType == OperationType.CASH_WITHDRAWAL.rawValue{
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: DetailIDVC.identifier) as? DetailIDVC{
                
                let vm = filteredPepperOperations[indexPath.row]
                
                vc.operationID = String(vm.operationId)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
}

extension FinancialOperationsTableVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredPepperOperations = []
        
        if searchText == "" {
            filteredPepperOperations = pepperOperations
        }
        else{
            for opr in pepperOperations {
                if opr.cellDataToSearch(searchText: searchText){
                    filteredPepperOperations.append(opr)
                }
            }
        }
        tableView.reloadData()
    }
}

extension FinancialOperationsTableVC: SavingRefundSalaryDelegate {
    func buttonTapped(id: Int) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailIDVC.identifier) as? DetailIDVC{
            
            vc.operationID = String(id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FinancialOperationsTableVC: ChargeCellDelegateCell{
    func iChargeButtonTapped(id: Int) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailIDVC.identifier) as? DetailIDVC{
            
            vc.operationID = String(id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}



