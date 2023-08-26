//
//  AddGlobalMessage.swift
//  YouAll Chat
//
//  Created by Umer on 26/08/2023.
//

import UIKit
import Firebase

class AddGlobalMessage: NSObject{
    
    let db = Firestore.firestore()

    func addMessage(messageBody :String){
        
        if let currentUser = Auth.auth().currentUser{
            
            db.collection(Global.collection).document().setData([Message.content:messageBody,
                                                                 Message.date: Date().formatted(),
                                                                 Message.timeStamp: Date().timeIntervalSince1970,
                                                                 Message.senderID: currentUser.uid,
                                                                 Message.senderPicture: currentUser.photoURL?.absoluteString ?? "" ,
                                                                 Message.sender: currentUser.displayName ?? "No Name"
                                                                ]) { Error in
                
                if Error != nil {
                    
                    print("error saving Global message\(String(describing: Error?.localizedDescription))")
                }else{
                    
                    print("global message saved")
                }
                
            }
            
        }
        
       
        
    }
}

