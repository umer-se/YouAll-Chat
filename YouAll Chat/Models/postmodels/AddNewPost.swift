//
//  AddNewPost.swift
//  YouAll Chat
//
//  Created by Umer on 15/08/2023.
//
protocol addNewPostDelegate{
    
    func refreshData()
}

import UIKit
import Firebase
import FirebaseStorage

class AddNewPost: NSObject{
    
    var delegate : addNewPostDelegate?
    var imageUrls: [String] = []
    let db = Firestore.firestore()
    var postID = ""
    var postBody = ""
    
    func addPost(postBody: String){
        
        let dbRef = db.collection(Post.collection).document()
        
        postID = dbRef.documentID
        
        if let user = Auth.auth().currentUser{
            let postModel = PostModel(postID: postID,
                                      sender: user.displayName ?? user.phoneNumber!,
                                      postBody: postBody,
                                      postImages: imageUrls,
                                      time: Date().formatted(),
                                      profileImage: user.photoURL?.absoluteString ?? "",
                                      timestamp: Date().timeIntervalSince1970, LikeBy: []
            )
            
            dbRef.setData([Post.postID: postModel.postID,
                           Post.content :postModel.postBody,
                           Post.images : postModel.postImages,
                           Post.sender : postModel.sender,
                           Post.senderImage : postModel.profileImage,
                           Post.date : postModel.time,
                           Post.timeStamp : postModel.timestamp,
                           Post.likeBy: postModel.LikeBy
                          ])
            { Error in
                if Error != nil{
                    print("Error saving post \(String(describing: Error?.localizedDescription))")
                    
                }else{
                    
                    print("post saved ")
                }
            }
        }
        
    }
    func uploadImage(_ attachedimage: [UIImage]){
        
        imageUrls.removeAll()
        var uploadImageCount = 0
        attachedimage.forEach { image in
            let imageName:String = String("\(Date().timeIntervalSince1970).png")
            let storageRef = Storage.storage().reference().child("postImages").child(imageName)
            
            if let uploadData = image.jpegData(compressionQuality: 0.2)
            {
                storageRef.putData(uploadData, metadata: nil
                                   , completion: { (metadata, error) in
                    if error != nil {
                        print("error")
                        print("Please try again later")
                        return
                    }else{
                        storageRef.downloadURL { url, error in
                            
                            guard let downloadURL = url else {
                                
                                print(error?.localizedDescription ?? "default value")
                                return
                            }
                            
                            self.imageUrls.append(downloadURL.absoluteString)
                            print("here")
                            
                            uploadImageCount += 1
                            if uploadImageCount == attachedimage.count{
                                self.updateImagesInFireStore()
                                self.delegate?.refreshData()
                                print("reload here")
                            }
                        }
                        
                    }
                }
                )}// uploadTask end
        }// attached image loop end
        
    }
    func updateImagesInFireStore(){
        
        let reference = db.collection(Post.collection).document(postID)
        
        reference.updateData([
            Post.images: imageUrls
            
        ]){error in
            
            if let error = error{
                print("error updating images\(error)")
                
            }else{
                
                print("success")
            }
            
        }
        
    }
    
}
