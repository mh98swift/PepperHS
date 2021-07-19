//
//  ViewController.swift
//  EDeveloperMVC
//
//  Created by MiciH on 7/19/21.
//

import UIKit

class UsersTableVC: UIViewController {
    
    var names = ["Michael", "David", "Paul", "Bob", "Steve"]
    var users: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ApiManager.shard.getUsers { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let users):
                DispatchQueue.main.async {
                    self.users = users
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension UsersTableVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return names.count
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if users[indexPath.row].name.contains("C"){
            cell.backgroundColor = .green
            cell.textLabel?.text = users[indexPath.row].name
        }
        else{
            cell.textLabel?.text = users[indexPath.row].name
        }
        
        
        return cell
    }
    
    
}

