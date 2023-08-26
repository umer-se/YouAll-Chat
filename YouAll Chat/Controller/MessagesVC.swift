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
    
    var conversation : ConversationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMessageRef.messageDelegate = self
        
        tableView.dataSource = loadMessageRef
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: K.MessageCell)
        
        loadMessageRef.getallmessages(conversation: conversation!)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        // print(conversationID)
        if let message = messageTextField.text {
            addMessageRef.addMessage(messageBody: message , conversationModel: conversation!)
            
        }
   }
    
}
extension MessagesVC: loadMessageDelegate{
    func scrollToNewMessage(indexPath: IndexPath) {
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    
    
}

    
    
    

