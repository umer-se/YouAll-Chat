//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
// 

import UIKit
import PhotosUI

class HomeVC : UIViewController{
    
    //MARK: - IBOutlets
    @IBOutlet weak var attachmentCollectionView: UICollectionView!
    @IBOutlet weak var deleteAttachmentButton: UIButton!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    let postsRef = loadPosts()
    let addPostRef = AddNewPost()

    let attachmentImageDataSource = AttachmentImageDataSource()
    let attachmentSource = AttachmentCell()
    
    let placeholder = "Whats on your Mind"

    let userAutentication = UserAuthentication()
    var postID = String()
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        tabBarController?.tabBar.isHidden = false
        navigationItem.hidesBackButton = true
        postsRef.delegate = self
        addPostRef.delegate = self
        postsRef.buttonDelegate = self

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postsRef.getPostsData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        postsRef.listener?.remove()
    }
    
    
    func setupSubviews(){
        deleteAttachmentButton.isHidden = true
        
        postTextView.text = placeholder
        postTextView.textColor =  UIColor.lightGray
        
        tableView.dataSource = postsRef
        tableView.delegate = postsRef
        tableView.register(UINib(nibName: "PostCell" , bundle: nil), forCellReuseIdentifier:K.PostIdentifier)

       
        attachmentImageDataSource.delegate = self
        attachmentCollectionView.dataSource = attachmentImageDataSource
        attachmentCollectionView.delegate = attachmentImageDataSource
        attachmentCollectionView.register(UINib(nibName: "AttachmentCell", bundle: nil), forCellWithReuseIdentifier: K.attachmentImageIdentifier)
        attachmentCollectionView.allowsMultipleSelection = true
        
    }
    //MARK: - IBActions
    
    @IBAction func deleteAttachmentPressed(_ sender: UIButton) {
        
        if let indexpaths = attachmentCollectionView.indexPathsForSelectedItems{
            var ToRemoveIndices = [Int]()
            indexpaths.forEach { index in
                ToRemoveIndices.append(index.item)
            }
            attachmentImageDataSource.deleteItems(at: ToRemoveIndices)
        }
        deleteAttachmentButton.isHidden = true
        attachmentCollectionView.reloadData()
    }
    
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func menuPressed(_ sender: UIButton) {
       print("pressed")
        
        performSegue(withIdentifier: "userInfo", sender: self)
        
    }
    
    @IBAction func SendPressed(_ sender: UIButton) {
        if let postText = postTextView.text {
            
            addPostRef.addPost(postBody: postText)
        }
        
        addPostRef.uploadImage(self.attachmentImageDataSource.images)
        
        attachmentImageDataSource.images.removeAll()
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
//MARK: - UITextViewDelegate

extension HomeVC: UITextViewDelegate{
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

extension HomeVC: AttachmentDataSourceDelegate{
    func didSelectItems() {
        
        deleteAttachmentButton.isHidden = false
    }
    
    func didDeselectItems() {
        
        deleteAttachmentButton.isHidden = true
    }
    
}

//MARK: - PHPickerViewControllerDelegate


extension HomeVC : PHPickerViewControllerDelegate {
    
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
        
        attachmentImageDataSource.images.append(pickedImage)
        attachmentCollectionView.reloadData()
    }
    
    
}
//MARK: - Posts DataSourceDelegate and addNewPostsDelegate
extension HomeVC: UpdateTableDelegate,addNewPostDelegate{
    
   
    
    func refreshData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}
//MARK: - Post Interaction delegate
extension HomeVC: postInteractionDelegate{
    func likePressed(ID: String, For: String) {
        postsRef.updateLikeValue(postID: ID, state : For )
    }
    
    func commentPresssed(id postID: String) {
        self.postID = postID
        performSegue(withIdentifier: K.commentsScreen, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comments" {
            let destinationVC = segue.destination as! CommentVC
            destinationVC.postID = postID
        }
      
    }
    
}
