//
//  CommentsFromDatabase.swift
//  YouAll Chat
//
//  Created by Umer on 21/08/2023.
//

import UIKit
import Firebase


class AddComments: NSObject{
    
    let db = Firestore.firestore()
    
    func addComment(comment :String,id : String){
        if let sender = Auth.auth().currentUser?.displayName
        {
            let commentModel = CommentModel.init(sender: sender, commentBody: comment, date: Date().formatted(), timeStamp: Date().timeIntervalSince1970)
            self.db.collection(P.PostCollection).document("comments").collection(id).document().setData(
                                                                          [P.commentSender:commentModel.sender,
                                                                           P.commentDate: commentModel.date,
                                                                           P.commentBody: commentModel.commentBody,
                                                                           P.commentTimeStamp: commentModel.timeStamp
                                                                               ], merge: true) { error in
                if let e = error{
                    print("there was an issue saving data to fibase---\(e.localizedDescription)")
                }else{
                    print("scomment saved")
                }
            }
        }
        
    }
    
    
}


