//
//  LoadGlobalMessage.swift
//  YouAll Chat
//
//  Created by Umer on 26/08/2023.
//

import UIKit
import Firebase

class LoadGlobalMessage: NSObject{
    
    let db = Firestore.firestore()
    var messages: [GlobalMessageModel] = []
    var globalMessageDelegate : loadMessageDelegate?
    
    func loadAllMessages(){
        
        
        db.collection(Global.collection)
            .order(by: Message.timeStamp)
            .addSnapshotListener { QuerySnapshot, error in
            
            if error != nil {
                
                print("Error getting Global message\(String(describing: error?.localizedDescription))")
                
            }else{
                self.messages = []
                for document in QuerySnapshot!.documents{
                    
                    let message = document.data()
                    
                    let globalMessageModel = GlobalMessageModel(content: message[Message.content] as? String ?? "no message",
                                                                sender: message[Message.sender] as? String ?? "No Name",
                                                                date: message[Message.date] as? String ?? "no date",
                                                                timeStamp: message[Message.timeStamp] as? Double ?? 0.0,
                                                                senderProfilePicture: message[Message.senderPicture] as? String ?? "",
                                                                senderID: message[Message.senderID] as? String ?? "no id"
                                                                )
                    
                    self.messages.append(globalMessageModel)
                        
                        
                    }
                    
                //delegate
                DispatchQueue.main.async {
                    self.globalMessageDelegate?.updateTable()
                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                    self.globalMessageDelegate?.scrollToNewMessage(indexPath: indexPath)
                }
               
                }
            }
            
        }

    }

extension LoadGlobalMessage: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.MessageCell, for: indexPath) as! messageCell
        let messageItem = messages[indexPath.row]
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser?.uid == messageItem.senderID{
            
            cell.setupGlobalmessage(sender: "self", message: messageItem)
            
        }else{
            cell.setupGlobalmessage(sender: "other", message: messageItem)
            
        }
        
        
        return cell
    }
    
    
    
    
}

    

