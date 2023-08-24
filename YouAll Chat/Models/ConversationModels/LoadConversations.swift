//
//  LoadConversations.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit
import Firebase


class LoadConversations: NSObject{
    
    var conversationDelegate : UpdateTableDelegate?
    var switchScreenDelegate: SwitchScreenDelegate?
    
    var selectedConversqationID :String = ""
    
    let db = Firestore.firestore()
    var conversations: [ConversationModel] = []
    
    func getData(){
        
        let userID = (Auth.auth().currentUser?.uid)!
        db.collection(Conv.conversationCollection).addSnapshotListener { QuerySnapshot, error in
            if error != nil{
                print("error in geting data about conversations")
                
            }else{
                if QuerySnapshot?.count == 0{
                    print("no item to display in converstions")
                    DispatchQueue.main.async {
                        self.conversationDelegate?.updateTable()
                    }
                         
                }else{
                    
                    self.conversations = []
                    
                    for document in QuerySnapshot!.documents{
                        
                        let conversation = document.data()
//                        let conversationModel = ConversationModel(
//                                        connversationID: conversation[Conv.conversationID] as? String ?? "",
//                                        reciever:conversation[Conv.reciever] as? String ?? "no value", ConversationWith: String,
//                                        lastMessage: conversation[Conv.lastMessage] as? String ?? "no value",
//                                        time: conversation[Conv.Date] as? Date ?? Date())
//                       
//
                        let conversationModel = ConversationModel(ConversationWith: conversation[Conv.conversationWith] as? String ?? "no value")
                        
                        self.conversations.append(conversationModel)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.conversationDelegate?.updateTable()
                    }
                        
                    
                }
            }
            
            
        }
        
        
    }
    
}
extension LoadConversations: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.conversationCell, for: indexPath) as! ConversationCell
        
        let conversationItem = conversations[indexPath.row]
        
//        cell.setupCell(reciever: conversationItem.reciever, lastMessage: conversationItem.lastMessage, time: conversationItem.time)
        cell.setupRow(conversationWith: conversationItem.ConversationWith)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationID = conversations[indexPath.row].ConversationWith
        selectedConversqationID = conversationID
       
        DispatchQueue.main.async {
            
            self.switchScreenDelegate?.switchScreen()
            
        }
       
        
        
        
    }
    
    
    
    
    
}

