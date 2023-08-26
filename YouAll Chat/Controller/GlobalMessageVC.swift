//
//  GlobalMessageVC.swift
//  YouAll Chat
//
//  Created by Umer on 26/08/2023.
//

import UIKit

class GlobalMessageVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    let addGlobalMessageRef = AddGlobalMessage()
    let loadGlobalMessageRef = LoadGlobalMessage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadGlobalMessageRef.globalMessageDelegate = self
        tableView.dataSource = loadGlobalMessageRef
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: K.MessageCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGlobalMessageRef.loadAllMessages()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let text = messageTextField.text{
            
            addGlobalMessageRef.addMessage(messageBody: text)
        }
        
    }
    
}
extension GlobalMessageVC:loadMessageDelegate{
    func scrollToNewMessage(indexPath: IndexPath) {
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
    func updateTable() {
        self.tableView.reloadData()
    }
    
    
    
}

