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
    let addConversations = AddConversation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        conversationRef.conversationDelegate = self
        conversationRef.switchScreenDelegate = self
        tableView.dataSource = conversationRef
        tableView.delegate = conversationRef
        
        addConversations.addConversationDelegate = self
        
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
            destinationVC.conversation = conversationRef.selectedConversqation
        }
        
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    
}
