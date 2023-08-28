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
    
    func addComment(commentBody :String, postID : String){
        if let sender = Auth.auth().currentUser
        {
            let commentModel = CommentModel(sender: sender.displayName ?? "No Name", commentBody: commentBody, date: Date().formatted(), timeStamp: Date().timeIntervalSince1970, userImage: sender.photoURL!.absoluteString)
            
            let dbRef = db.collection(Post.collection).document(postID).collection(Comment.collection).document()
            
            dbRef.setData([
                Comment.content: commentModel.commentBody,
                Comment.id: dbRef.documentID,
                Comment.Sender: commentModel.sender,
                Comment.Image : commentModel.userImage,
                Comment.Date : commentModel.date,
                Comment.TimeStamp : commentModel.timeStamp
            ])
            { error in
                if let e = error{
                    print("there was an issue saving data to fibase---\(e.localizedDescription)")
                }else{
                    print("scomment saved")
                }
            }
        }
    }
}


