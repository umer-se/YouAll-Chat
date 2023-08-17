//
//  PostsDataSource.swift
//  YouAll Chat
//
//  Created by Umer on 17/08/2023.
//

import UIKit
import Firebase

class PostsDataSource: NSObject{
    var postCount:Int?
    var posts :[PostModel] = []
    
    let db = Firestore.firestore()
    
    func getPostsData(){
        
        db.collection(FStore.PostCollection).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                     let postFields = document.data()
                        let postModel = PostModel(sender: (postFields[FStore.Postsender] as? String)!,
                                                  postBody: (postFields[FStore.PostBody] as? String),
                                                  postImages: (postFields[FStore.postImages] as? [String]),
                                                  time: (postFields[FStore.dateField] as? String ?? "default value"))

                    self.posts.append(postModel)

                }
            }
        }
    }
    
}
extension PostsDataSource : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userFeedPostsIdentifier , for: indexPath) as! Post
        cell.setupRow(sender: posts[indexPath.row].sender,
                      postBodey: posts[indexPath.row].postBody ?? "",
                      postImages: posts[indexPath.row].postImages ?? [],
                      time: posts[indexPath.row].time)
        
        return cell;
    }
    
    
}




