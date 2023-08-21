//
//  PostsDataSource.swift
//  YouAll Chat
//
//  Created by Umer on 17/08/2023.
//
protocol PostsDatasourceDelegate{
    
    func updateTable()
}




import UIKit
import Firebase

class PostsFromDatabase: NSObject{
    
    var delegate : PostsDatasourceDelegate?

    var buttonDelegate: postInteractionDelegate?
    
   
    var postCount:Int?
    var posts :[PostModel] = []
    
    let db = Firestore.firestore()
    
    func getPostsData(){
        
        db.collection(FS.PostCollection)
            .addSnapshotListener{ querySnapshot, err  in
                
                self.posts = []
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in querySnapshot!.documents{
                        
                        let postFields = document.data()
                        let postModel = PostModel(postID: (postFields[FS.postID] as? String)!,
                                                  sender: (postFields[FS.Postsender] as? String)!,
                                                  postBody: (postFields[FS.PostBody] as? String)!,
                                                  postImages: (postFields[FS.postImages] as? [String]) ?? [],
                                                  time: (postFields[FS.dateField] as? String ?? "default value"))
                        
                        self.posts.append(postModel)
                        
                    }
                }
            
                self.delegate?.updateTable()
            }
    }
    
}
extension PostsFromDatabase : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.PostIdentifier , for: indexPath) as! Post
        
        let postItem = posts[indexPath.row]
        
        cell.buttonDelegate = self.buttonDelegate
        cell.setupRow(postID: postItem.postID, sender: postItem.sender,
                      postBody: postItem.postBody,
                      postImages: postItem.postImages.count > 0 ? postItem.postImages : [] ,
                      time: postItem.time)
        
               return cell;
    }
    
}




