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
    
    var selectedConversqation :ConversationModel?
    
    let db = Firestore.firestore()
    var conversations: [ConversationModel] = []
    var conversationID: [String] = []
    
    var listener : ListenerRegistration?
    
    func getData(){
        
      listener = db.collection(Conversation.collection).addSnapshotListener { QuerySnapshot, error in
            if error != nil{
                print("error in geting data about conversations")
                
            }else{
                if QuerySnapshot?.count == 0{
                    print("no item to display in converstions")
                    self.conversations = []
                    DispatchQueue.main.async {
                        self.conversationDelegate?.updateTable()
                    }
                    
                }else{
                    
                    self.conversations = []
                    for document in QuerySnapshot!.documents{
                        
                        let conversation = document.data()
                        
                        if self.conversationID.contains(conversation[Conversation.ID] as! String){
                            
                            
                            let conversationModel = ConversationModel(time: conversation[Conversation.time] as? String ?? "no time",
                                                                      recieverID: conversation[Conversation.recieverID] as! String,
                                                                      createrID: conversation[Conversation.createrID] as! String,
                                                                      recieverName: conversation[Conversation.recieverName] as? String ?? "No Name",
                                                                      CreaterName: conversation[Conversation.createrName] as? String ?? "No Name",
                                                                      conversationID: conversation[Conversation.ID] as! String,
                                                                      createrPicture: conversation[Conversation.createrPicture] as? String ?? " ",
                                                                      recieverPicture: conversation[Conversation.recieverPicture] as? String ?? " ")
                            
                            self.conversations.append(conversationModel)
                        }
                    }// end loop
                    
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
        
        let currentUser = Auth.auth().currentUser
        
        let conversationItem = conversations[indexPath.row]
        
        if currentUser?.uid == conversationItem.createrID{
            
            cell.setupRow(recieverName: conversationItem.recieverName, profileImage: conversationItem.recieverPicture,time: conversationItem.time)
        }else{
            cell.setupRow(recieverName: conversationItem.CreaterName, profileImage: conversationItem.createrPicture , time: conversationItem.time)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        selectedConversqation = conversation
        
        DispatchQueue.main.async {
            
            self.switchScreenDelegate?.switchScreen()
            
        }
        
        
    }
    
    // get user specific conversations here
    
    func getConversations(){
        let userID = (Auth.auth().currentUser?.uid)!
        db.collection(Conversation.Participants).getDocuments { QuerySnapshot, error in
            if error != nil {
                print("during getConversationID \(String(describing: error?.localizedDescription))")
            }
            else{
                self.conversationID = []
                for document in QuerySnapshot!.documents{
                    
                    let conversation = document.data()
                    if let user = conversation[Conversation.user] {
                        if user as! String == userID{
                            self.conversationID.append(conversation[Conversation.ID] as! String)
                        }
                    }
                }//end loop
                self.getData()
                
            }
        }
        
    }
    
}

