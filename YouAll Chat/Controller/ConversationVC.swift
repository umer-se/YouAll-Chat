//
//  ConversationVC.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit


class ConversationVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let conversationRef = LoadConversations()
    let availableUsers = AvailableUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        conversationRef.conversationDelegate = self
        conversationRef.switchScreenDelegate = self
        tableView.dataSource = conversationRef
        tableView.delegate = conversationRef
        
        availableUsers.addConversationDelegate = self
        
        tableView.register(UINib(nibName: "ConversationCell", bundle: nil), forCellReuseIdentifier: K.conversationCell)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        conversationRef.getConversations()
    }
    
    @IBAction func AddUserPressed(_ sender: UIButton) {
        
        
    }
}




extension ConversationVC : UpdateTableDelegate,SwitchScreenDelegate{
    
    func switchScreen() {
        performSegue(withIdentifier: K.chatView, sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatView"{
            let destinationVC = segue.destination as! MessagesVC
            destinationVC.conversationID = conversationRef.selectedConversqationID
        }
        
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    
}
