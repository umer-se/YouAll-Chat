//
//  LoadComments.swift
//  YouAll Chat
//
//  Created by Umer on 21/08/2023.
//

import UIKit
import Firebase

class LoadComments: NSObject{
    
    var commnetDelegate : UpdateTableDelegate?
    
    var comments :[CommentModel] = []
    
    let db = Firestore.firestore()
    
    func getCommentsForPostWith(postID :String){
        db.collectionGroup(postID).addSnapshotListener{ querySnapshot, err  in
            
           // self.comments = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // here write a query to only load comments for a post id
                
                
                for document in querySnapshot!.documentChanges{
                    
                    let comments =  document.document.data()
                    let commentModel = CommentModel(sender: comments[P.commentSender] as? String ?? "",
                                                        commentBody: comments[P.commentBody] as? String ?? "",
                                                    date: comments[P.commentDate] as? String ?? "",
                                                    timeStamp: comments[P.commentTimeStamp] as? Double ?? 0.0,
                                                    userImage: comments[P.commenterProfileImage] as? String ?? "" )
                        
                        
                        self.comments.append(commentModel)
               
                    
                    
                    
                    }
                    
                self.comments = self.comments.sorted { this1, this2 in
                    this1.timeStamp < this2.timeStamp
                }
                
                self.commnetDelegate?.updateTable()
            }
        }
    }
}

extension LoadComments:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.commentCell, for: indexPath) as! CommentCell
        
        let commentItem = comments[indexPath.row]
        
        cell.setupRow(comment: commentItem)
        
        
        return cell
    }
    
   
    
    
    
}

