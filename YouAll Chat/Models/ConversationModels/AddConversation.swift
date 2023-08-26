//
//  AddConversation.swift
//  YouAll Chat
//
//  Created by Umer on 24/08/2023.
//

import UIKit
import Firebase


class AddConversation: NSObject{
    
    let db = Firestore.firestore()
    var addConversationDelegate : UpdateTableDelegate?
    
    
    func checkIfConversationExists(_ selectedUser : UserModel) {
        var flag = true
        let currentUser = (Auth.auth().currentUser)!
        
        db.collection(Conversation.Collection).getDocuments { QuerySnapshot, error in
            if error != nil{
                print("error during fetching all users from database \(String(describing: error?.localizedDescription))")
            }
            else
            {
                if QuerySnapshot?.documents.count == 0{
                    flag = false
                }
                
                for document in QuerySnapshot!.documents{
                    
                    let conversation = document.data()
                    if let creater = conversation[Conversation.CreaterID], let with = conversation [Conversation.RecieverID] {
                        if creater as! String == currentUser.uid && with as! String == selectedUser.uid{
                            print("conversation already exists.")
                            flag = true
                            break
                        }else{
                            flag = false
                        }
                    }
                }
                if !flag {
                    self.addConversation(currentUser: currentUser,selectedUser: selectedUser)
                }
            }
        }
    }
    func addConversation(currentUser: User,selectedUser : UserModel) {
        
        let conversationModel = ConversationModel(time: Date().formatted(),
                                                  recieverID: selectedUser.uid,
                                                  createrID: currentUser.uid,
                                                  recieverName: selectedUser.Name ?? "No Name",
                                                  CreaterName: currentUser.displayName ?? "No Name" ,
                                                  conversationID: "",
                                                  createrPicture: currentUser.photoURL!.absoluteString,
                                                  recieverPicture: selectedUser.profilePicture)
        
        let dbRef = db.collection(Conversation.Collection).document()
        
        dbRef.setData([Conversation.RecieverID: conversationModel.recieverID,
                       Conversation.CreaterID: conversationModel.createrID,
                       Conversation.ID: dbRef.documentID,
                       Conversation.recieverName : conversationModel.recieverName ,
                       Conversation.createrName : conversationModel.CreaterName,
                       Conversation.recieverPicture: conversationModel.recieverPicture,
                       Conversation.createrPicture: conversationModel.createrPicture
                      ]) { error in
            if let e = error{
                print("there was an issue saving data to fibase---\(e.localizedDescription)")
            }else{
                print("conversation with selected user is started")
                DispatchQueue.main.async {
                    self.addConversationDelegate?.updateTable()
                }
                
                self.setConversationPaticipant(conversationID: dbRef.documentID, selectedUser: selectedUser.uid, currentUser: currentUser.uid)
                
            }
        }
    }
    
    
    func setConversationPaticipant(conversationID:String, selectedUser:String, currentUser:String){
        saveParticipant(conversationID, selectedUser)
        saveParticipant(conversationID, currentUser)
    }
    fileprivate func saveParticipant(_ conversationID: String, _ selectedUser: String) {
        db.collection(Conversation.Participants).document().setData([Conversation.ID:conversationID,
                                                                     Conversation.user: selectedUser])
        { error in
            if let e = error{
                print("there was an issue saving data to fibase---\(e.localizedDescription)")
            }else{
                print("conversation participation for selected user is added")
                DispatchQueue.main.async {
                    self.addConversationDelegate?.updateTable()
                }
            }
            
        }
    }
    
    
    
    
}

