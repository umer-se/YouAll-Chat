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
    var listenerDelegate :DeAttachListener?
    var comments :[CommentModel] = []
    
    let db = Firestore.firestore()
    var listener :ListenerRegistration?
    
    func getCommentsForPostWith(postID :String){
    listener = db.collection(Post.collection)
            .document(postID)
            .collection(Comment.collection)
            .order(by: Comment.TimeStamp)
            .addSnapshotListener  { querySnapshot, err  in
            
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.comments = []
                for document in querySnapshot!.documents{
                    
                    let comment = document.data()
                    let commentModel = CommentModel(sender: comment[Comment.Sender] as? String ?? "",
                                                    commentBody: comment[Comment.content] as? String ?? "no comment",
                                                    date: comment[Comment.Date] as? String ?? "",
                                                    timeStamp: comment[Comment.TimeStamp] as? Double ?? 0.0,
                                                    userImage: comment[Comment.Image] as? String ?? ""
                    )
                    self.comments.append(commentModel)
                }
                DispatchQueue.main.async {
                    self.commnetDelegate?.updateTable()
                }
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

