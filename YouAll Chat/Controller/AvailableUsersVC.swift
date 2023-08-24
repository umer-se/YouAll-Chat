//
//  AddConversationVC.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit

class AvailableUsersVC:UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    let availableUsersRef = AvailableUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = availableUsersRef
        tableView.delegate = availableUsersRef
        availableUsersRef.availableUserDelegate = self
        availableUsersRef.avialableDidSelectDelegate = self
        
        tableView.register(UINib(nibName: "AvailableUserCell", bundle: nil), forCellReuseIdentifier: K.availableUserCell)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        availableUsersRef.getallUsersOnNetwork()
    }
    
}
extension AvailableUsersVC:UpdateTableDelegate,SwitchScreenDelegate{
    func switchScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
}

