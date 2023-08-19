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

class PostsDataSource: NSObject{
    var delegate : PostsDatasourceDelegate?
    var postCount:Int?
    var posts :[PostModel] = []
    
    let db = Firestore.firestore()
    
    func getPostsData(){
        
        db.collection(FStore.PostCollection)
            .addSnapshotListener{ querySnapshot, err  in
                
                self.posts = []
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents{
                        
                        let postFields = document.data()
                        let postModel = PostModel(sender: (postFields[FStore.Postsender] as? String)!,
                                                  postBody: (postFields[FStore.PostBody] as? String)!,
                                                  postImages: (postFields[FStore.postImages] as? [String]) ?? [],
                                                  time: (postFields[FStore.dateField] as? String ?? "default value"))
                        
                        self.posts.append(postModel)
                        
                    }
                }
            
                self.delegate?.updateTable()
            }
    }
    
}
extension PostsDataSource : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userFeedPostsIdentifier , for: indexPath) as! Post
        
        let postItem = posts[indexPath.row]
        
        
        cell.setupRow(sender: postItem.sender,
                      postBodey: postItem.postBody,
                      postImages: postItem.postImages.count > 0 ? postItem.postImages : [] ,
                      time: postItem.time)
        
               return cell;
    }
    
}




