//
//  LoadMessages.swift
//  YouAll Chat
//
//  Created by Umer on 23/08/2023.
//

import UIKit
import Firebase


class LoadMessages:NSObject{
    var messageDelegate : loadMessageDelegate?
    
    let db = Firestore.firestore()
    var messages:[MessageModel] = []
    
    var listener: ListenerRegistration?
    
    func getallmessages(conversation: ConversationModel){
        
     listener = db.collection(Conversation.collection)
            .document(conversation.conversationID)
            .collection(Message.collection)
            .order(by: Message.timeStamp)
            .addSnapshotListener({ QuerySnapshot, Error in
                if let err = Error {
                    print("Error in loading message \(err.localizedDescription)")
                    
                }else{
                    self.messages = []
                    for document in QuerySnapshot!
                        .documents{
                        let message = document.data()
                        
                        let messageModel = MessageModel(sender: message[Message.sender] as! String,
                                                        recipient: message[Message.recipient] as! String,
                                                        content: message[Message.content] as! String,
                                                        senderID: message[Message.senderID] as! String,
                                                        recipientID: message[Message.recipientId] as! String ,
                                                        time: message[Message.date] as! String,
                                                        timeStamp: message[Message.timeStamp] as? Double ?? 0.0,
                                                        senderpicture: message[Message.senderPicture] as! String,
                                                        recipientPicture: message[Message.recipientPicture] as! String
                        )
                        self.messages.append(messageModel)
                    }
                    DispatchQueue.main.async {
                        self.messageDelegate?.updateTable()
                        if self.messages.count > 1{
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.messageDelegate?.scrollToNewMessage(indexPath: indexPath)
                        }
                        
                    }
                    
                }
            })
    }
}

extension LoadMessages: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageCell, for: indexPath) as! messageCell
        let messageItem = messages[indexPath.row]
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser?.uid == messageItem.senderID{
            
            cell.setupRow(sender: "self", message: messageItem)
            
        }else{
            cell.setupRow(sender: "other", message: messageItem)
            
        }
        
        
        return cell
    }
    
    
    
}



