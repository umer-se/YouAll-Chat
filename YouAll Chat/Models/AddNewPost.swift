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
     
    func addNewPost(postBody : String){
        // only check once if the same key exist implement it correctly in future
        if !checkAvailabilityForID(id: postID){
            updateFirebase(PostBody: postBody)
        }else{
            
        }
        self.postBody = postBody
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
                            self.updateImagesInFireStore()
                            uploadImageCount += 1
                            if uploadImageCount == attachedimage.count{
                                
                                self.delegate?.refreshData()
                                print("reload here")
                            }
                        }
                        
                    }
                }
                )}// uploadTask end
        }// attached image loop end
        
    }
    
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    // make this function more effiecint in funture.
    func checkAvailabilityForID(id: String)-> Bool{
        
        var flag = false
        postID = randomString(length: 10)
        
        let docRef = db.collection(FS.PostCollection).document(postID)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists{
                print("id exists")
                flag = true
            }
            else
            {
                flag = false
                print("id available")
                
            }
        }
        return flag
    }
    
    func updateFirebase(PostBody : String ){
        print(imageUrls.count)
        if let sender = Auth.auth().currentUser?.phoneNumber
        {
            let postModel = PostModel.init(postID: postID, sender: sender, postBody: PostBody, postImages: imageUrls , time: Date().formatted())
            
            self.db.collection(FS.PostCollection).document(postID).setData([FS.postID : postModel.postID,
                                                                                FS.Postsender: postModel.sender,
                                                                                FS.PostBody: postModel.postBody ,
                                                                                FS.dateField: postModel.time,
                                                                                FS.postImages: postModel.postImages
                                                                               ]) { error in
                if let e = error{
                    print("there was an issue saving data to fibase---\(e.localizedDescription)")
                }else{
                    print("saved data")
                }
            }
        }
    }
    
    func updateImagesInFireStore(){
        let reference = db.collection(FS.PostCollection).document(postID)
        
        reference.updateData([
            FS.postImages: imageUrls
        ]){error in
            
            if let error = error{
                print("error updating images\(error)")
                
            }else{
                
                print("success")
            }
            
        }
        
    }
    
}





