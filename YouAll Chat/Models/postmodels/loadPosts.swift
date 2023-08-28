//
//  PostsDataSource.swift
//  YouAll Chat
//
//  Created by Umer on 17/08/2023.
//
protocol UpdateTableDelegate{
    
    func updateTable()
}




import UIKit
import Firebase

class loadPosts: NSObject{
    
    var delegate : UpdateTableDelegate?

    var buttonDelegate: postInteractionDelegate?
    
   
    var postCount:Int?
    var posts :[PostModel] = []
    
    let db = Firestore.firestore()
    
    var listener : ListenerRegistration?
    
    func getPostsData(){
        
      listener = db.collection(Post.collection)
            .addSnapshotListener{ querySnapshot, err  in
                
                self.posts = []
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in querySnapshot!.documents{
                        
                        let postFields = document.data()
                        let postModel = PostModel(postID: postFields[Post.postID] as? String ?? "",
                                                  sender: postFields[Post.sender] as? String ?? "",
                                                  postBody: postFields[Post.content] as? String ?? "",
                                                  postImages: postFields[Post.images] as? [String] ?? [],
                                                  time: postFields[Post.date] as? String ?? "default value",
                                                  profileImage: postFields[Post.senderImage] as? String ?? "",
                                                  timestamp: postFields[Post.timeStamp] as? Double ?? 0.0,
                                                  LikeBy: postFields[Post.likeBy] as? [String] ?? []
                                                )    
                        self.posts.append(postModel)
                        
                    }
                }
            
                self.delegate?.updateTable()
            }
    }
    
    func updateLikeValue(postID:String, state: String){
        
        if let UserID = Auth.auth().currentUser?.uid{
          let dbRef =  db.collection(Post.collection).document(postID)
            
            if state == "like"{
                dbRef.updateData([
                        Post.likeBy:FieldValue.arrayUnion([UserID])
                    ])
            }else
            {
                dbRef.updateData([
                    Post.likeBy:FieldValue.arrayRemove([UserID])
                    ])
            }
        }
    }
}

extension loadPosts : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.PostIdentifier , for: indexPath) as! PostCell
        
        let postItem = posts[indexPath.row]
        cell.buttonDelegate = self.buttonDelegate
        cell.setupRow(postItem: postItem)
        
               return cell;
    }
    
    
}




