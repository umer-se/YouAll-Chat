//
//  MessagesVC.swift
//  YouAll Chat
//
//  Created by Umer on 23/08/2023.
//

import UIKit

class MessagesVC : UIViewController{

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let addMessageRef = AddMessage()
    let loadMessageRef = LoadMessages()
    
    var conversationID :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMessageRef.messageDelegate = self
        
        tableView.dataSource = loadMessageRef
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: K.MessageCell)
        
        loadMessageRef.getallmessages(conversationID: conversationID)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        print(conversationID)
        if let message = messageTextField.text {
            
            addMessageRef.addMessage(messageBody: message, conversationID)
        }
        messageTextField.text = ""
   }
    
}
extension MessagesVC: UpdateTableDelegate{
    func updateTable() {
        tableView.reloadData()
    }
    
    
    
}

    
    
    

