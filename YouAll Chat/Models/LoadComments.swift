//
//  LoadComments.swift
//  YouAll Chat
//
//  Created by Umer on 21/08/2023.
//

import UIKit
import Firebase

class LoadComments: NSObject{
    
    var comments :[CommentModel] = []
    
    let db = Firestore.firestore()
    
    func getCommentsForPostWith(postID :String){
        db.collection(FS.commentCollection).addSnapshotListener{ querySnapshot, err  in
            
            self.comments = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents.filter({ this in
                    this.documentID == postID
                }){
                    
                    let comments =  document.data()
                    let commentModel = CommentModel(sender: comments[FS.commentSender] as! String,
                                                    commentBody: comments[FS.commentBody] as! String)
                    
                    
                    self.comments.append(commentModel)
                }
                
            }
            
        }
        
    }
}

