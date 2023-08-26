//
//  AddMessage.swift
//  YouAll Chat
//
//  Created by Umer on 23/08/2023.
//

import UIKit
import Firebase

class AddMessage: NSObject{
    let db = Firestore.firestore()
    
    func addMessage(messageBody :String , conversationModel :ConversationModel){
        
        if Auth.auth().currentUser?.uid == conversationModel.createrID{
            
            db.collection(Conversation.Collection)
                .document(conversationModel.conversationID)
                .collection(Message.collection)
                .document()
                .setData([Message.content:messageBody,
                          Message.date: Date().formatted(),
                          Message.timeStamp: Date().timeIntervalSince1970,
                          Message.recipientId: conversationModel.recieverID,
                          Message.recipientPicture: conversationModel.recieverPicture,
                          Message.recipient: conversationModel.recieverName,
                          Message.senderID: conversationModel.createrID,
                          Message.senderPicture: conversationModel.createrPicture,
                          Message.sender: conversationModel.CreaterName
                         ])
            { Error in
                if Error != nil{
                    print(Error!.localizedDescription)
                    
                }else{
                    
                    print("message is added to database")
                }
            }
            
        }else{
            // change sender  and recipients fields
           
            db.collection(Conversation.Collection)
                .document(conversationModel.conversationID)
                .collection(Message.collection)
                .document()
                .setData([Message.content:messageBody,
                          Message.date: Date().formatted(),
                          Message.timeStamp: Date().timeIntervalSince1970,
                          Message.recipientId: conversationModel.createrID,
                          Message.recipientPicture: conversationModel.createrPicture,
                          Message.recipient: conversationModel.CreaterName,
                          Message.senderID: conversationModel.recieverID,
                          Message.senderPicture: conversationModel.recieverPicture,
                          Message.sender: conversationModel.recieverName
                         ])
            { Error in
                if Error != nil{
                    print(Error!.localizedDescription)
                    
                }else{
                    
                    print("message is added to database")
                }
            }
        }
    }
}
