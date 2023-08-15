//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
// 

import UIKit
import Firebase
import FirebaseStorage
import PhotosUI

class HomeViewController : UIViewController{

    
    
    //MARK: - IBOutlets
    @IBOutlet weak var attachmentCollectionView: UICollectionView!
    @IBOutlet weak var deleteAttachmentButton: UIButton!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    let db = Firestore.firestore()
    let attachmentDataSource = AttachmentImageDataSource()
    var atttachmentImageArrayURLS = [String]()
  
    
    let placeholder = "Whats on your Mind"
    let userAutentication = UserAuthentication()
    let postSource = Post()
    let attachmentSource = AttachmentCell()
   
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        
        
        postTextView.text = placeholder
        postTextView.textColor =  UIColor.lightGray
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "Post" , bundle: nil), forCellReuseIdentifier:K.userFeedPostsIdentifier)
        
       
        attachmentCollectionView.register(UINib(nibName: "AttachmentCell", bundle: nil), forCellWithReuseIdentifier: K.attachmentImageIdentifier)
        attachmentCollectionView.allowsMultipleSelection = true
        
      
    }
    
    func setupSubviews(){
        deleteAttachmentButton.isHidden = true
    
        
        attachmentDataSource.delegate = self
        attachmentCollectionView.dataSource = attachmentDataSource
        attachmentCollectionView.delegate = attachmentDataSource
    }
    
    @IBAction func deleteAttachmentPressed(_ sender: UIButton) {
        
        if let indexpaths = attachmentCollectionView.indexPathsForSelectedItems{
            var ToRemoveIndices = [Int]()
            indexpaths.forEach { index in
                ToRemoveIndices.append(index.item)
            }
            attachmentDataSource.deleteItems(at: ToRemoveIndices)
        }
        
        attachmentCollectionView.reloadData()
    }
        

    @IBAction func refreshPressed(_ sender: UIButton) {
        tableView.reloadData()
        attachmentCollectionView.reloadData()
    }
    
    @IBAction func SendPressed(_ sender: UIButton) {
        addNewPost()
        
    }
    
    
    @IBAction func logOutPressed(_ sender: UIButton) {
 
        userAutentication.logOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func attachmentImageButtonPressed(_ sender: UIButton) {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 10
        configuration.filter = PHPickerFilter.images
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = self
        
        present(imagePicker, animated: true,completion: nil)
       
    }
        
    
    
}
//MARK: - tableView datasource

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postSource.images.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userFeedPostsIdentifier , for: indexPath) as! Post
        return cell;
        
    }
    
}
//MARK: - Add new Post code is under here

//MARK: - UITextViewDelegate

extension HomeViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.text = ""
        textView.textColor = UIColor.black
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        
        // here is code to store a new post on firebase
        
    }
    
}

//MARK: - firebase code for storing post in data base

extension HomeViewController{
    
    func addNewPost(){

        if let postBody = postTextView.text,
           let sender = Auth.auth().currentUser?.phoneNumber
        {
            let postModel = PostModel.init(sender: sender, postBody: postBody, postImages: atttachmentImageArrayURLS, time: Date())
            
            db.collection(FStore.PostCollection).addDocument(data: [FStore.Postsender: postModel.sender,
                                                                    FStore.PostBody: postModel.postBody ?? "",
                                                                    FStore.dateField: postModel.time,
                                                                    FStore.postImages: postModel.postImages ?? ""
                                                                   ]) { error in
                if let e = error{
                    print("there was an issue saving thw data to fibase---\(e.localizedDescription)")
                }else{
                    print("saved data")
                    DispatchQueue.main.async {
                        self.postTextView.text = self.placeholder
                        self.postTextView.textColor = UIColor.lightGray
                    }
                    
                }
            }
        }
    }
    
    //MARK: - Upload image
    func uploadImage(_ image: UIImage){
        
        let imageName:String = String("\(Date().timeIntervalSince1970).png")
        
        let storageRef = Storage.storage().reference().child("postImages").child(imageName)
        
        if let uploadData = image.jpegData(compressionQuality: 0.2)
        {
            let uploadTask = storageRef.putData(uploadData, metadata: nil
                                                , completion: { (metadata, error) in
                if error != nil {
                    print("error")
                    print("Please try again later")
                    return
                }else{
                    
                    
                }
                print(metadata!)
                storageRef.downloadURL { url, error in
                    
                    guard let downloadURL = url else {
                        
                        print(error?.localizedDescription ?? "default value")
                        return
                    }
                    self.atttachmentImageArrayURLS.append(downloadURL.absoluteString)
                }
            }
                                                
            )//upload task
//            let observer = uploadTask.observe(.progress) { snapshot in
//                // Upload reported progress
//            }
        }
    }
    
}


//MARK: - AttachmentDataSource Delegate

extension HomeViewController: AttachmentDataSourceDelegate{
    func didSelectItems() {
     
        deleteAttachmentButton.isHidden = false
    }
    
    func didDeselectItems() {
        
        deleteAttachmentButton.isHidden = true
    }
    
    
    
}
extension HomeViewController : PHPickerViewControllerDelegate {
    

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true,completion: nil)


        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let pickedImage = object as? UIImage {
                    DispatchQueue.main.async {
                        // Use UIImage

                        self.AddToAttachmentImageArray(pickedImage)
                    }
                }
            })
        }

    }

    func AddToAttachmentImageArray(_ pickedImage: UIImage){

        attachmentDataSource.images.append(pickedImage)
        attachmentCollectionView.reloadData()


    }


}
