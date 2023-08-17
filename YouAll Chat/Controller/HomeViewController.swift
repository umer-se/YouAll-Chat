//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
// 

import UIKit
import PhotosUI

class HomeViewController : UIViewController{

    
    
    //MARK: - IBOutlets
    @IBOutlet weak var attachmentCollectionView: UICollectionView!
    @IBOutlet weak var deleteAttachmentButton: UIButton!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
 
    let postsDataSource = PostsDataSource()
    let attachmentDataSource = AttachmentImageDataSource()
    var atttachmentImageURLS : [String] = []
    let postObject = AddNewPost()
  
    
    let group = DispatchGroup()
    let serialQueue = DispatchQueue(label: "uploadImage.queue")
  
    
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
        
        //tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "Post" , bundle: nil), forCellReuseIdentifier:K.userFeedPostsIdentifier)
        
       
        attachmentCollectionView.register(UINib(nibName: "AttachmentCell", bundle: nil), forCellWithReuseIdentifier: K.attachmentImageIdentifier)
        attachmentCollectionView.allowsMultipleSelection = true
        
        // load data from firebase
        
        postsDataSource.getPostsData()
       // tableView.reloadData()
       
      
        
    }
    
    func setupSubviews(){
        deleteAttachmentButton.isHidden = true
    
        tableView.dataSource = postsDataSource
        tableView.delegate = postsDataSource

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
        deleteAttachmentButton.isHidden = true
        attachmentCollectionView.reloadData()
    }
        

    @IBAction func refreshPressed(_ sender: UIButton) {
        tableView.reloadData()
        attachmentCollectionView.reloadData()
    }
    
    
    @IBAction func SendPressed(_ sender: UIButton) {
        let postText = postTextView.text ?? ""
 
            postObject.addNewPost(postBody: postText)
            postObject.uploadImage(self.attachmentDataSource.images)
      
        
            attachmentDataSource.images.removeAll()
            postTextView.text = ""
            attachmentCollectionView.reloadData()
         
        
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

//extension HomeViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return postSource.images.count;
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.userFeedPostsIdentifier , for: indexPath) as! Post
//        return cell;
//
//    }
    
//}

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
        
 
        // here write code to store a new post on firebase
        
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

//MARK: - PHPickerViewControllerDelegate


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
