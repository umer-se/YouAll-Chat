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
    
    
    func addMessage(messageBody :String, _ conversationID: String){
        
        if let userID = Auth.auth().currentUser?.uid{
            db.collection(FirebaseUser.UserColletion)
                .document(userID)
                .collection(conversationID)
                .document()
                .setData([Message.sendBy :conversationID,
                          Message.message :messageBody]) { error in
                    if let e = error{
                        print("there was an issue saving data to fibase---\(e.localizedDescription)")
                    }else{
                        print("messsage is added ")
                        
                        
                    }
                    
                }
        }
    }
}
