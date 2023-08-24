//
//  LoadMessages.swift
//  YouAll Chat
//
//  Created by Umer on 23/08/2023.
//

import UIKit
import Firebase


class LoadMessages:NSObject{
    var messageDelegate : UpdateTableDelegate?
    
    let db = Firestore.firestore()
    var messages:[MessageModel] = []
    
    func getallmessages(conversationID: String){
        
        db.collectionGroup(conversationID).addSnapshotListener { QuerySnapshot, error in
            if error != nil{
                print("error in geting data about messages")
                
            }else{
                if QuerySnapshot?.count == 0{
                    print("no item to display in messages")
                    DispatchQueue.main.async {
                        self.messageDelegate?.updateTable()
                    }
                    
                }else{
                    
                    self.messages = []
                    
                    for document in QuerySnapshot!.documents{
                        
                        let message = document.data()
                        let messageModel = MessageModel(sender :message[Message.sendBy] as? String ?? "",
                                                        messageBody: message[Message.message] as? String  ?? "")
                        
                        self.messages.append(messageModel)
                    }
                    
                    DispatchQueue.main.async {
                        self.messageDelegate?.updateTable()
                    }
                }
            }
        }
    }
}

extension LoadMessages: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.MessageCell, for: indexPath) as! messageCell
        let messageItem = messages[indexPath.row]
        
        var sender = "self"
        
        let currentUserID = Auth.auth().currentUser?.uid
        print(currentUserID)
        print(messageItem.sender)
        
        if currentUserID == messageItem.sender{
            sender = "other"
        }
    
        cell.setupRow(sender:sender , messageBody: messageItem.messageBody)
        return cell
    }
    
    
    
}







