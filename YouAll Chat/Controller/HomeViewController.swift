//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
// 

import UIKit
import PhotosUI
import Firebase


class HomeViewController : UIViewController{
    
    
    @IBOutlet weak var attachmentCollectionView: UICollectionView!
    
    @IBOutlet weak var deleteAttachmentButton: UIButton!
    
    @IBOutlet weak var postTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    
    var AttachmentImageArray = [UIImage]()
    
    
    let placeholder = "Whats on your Mind"
    let userAutentication = UserAuthentication()
    let postSource = Post()
    let attachmentSource = AttachmentCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteAttachmentButton.isHidden = true
        
        postTextView.text = placeholder
        postTextView.textColor =  UIColor.lightGray
        
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "Post" , bundle: nil), forCellReuseIdentifier:K.userFeedPostsIdentifier)
        
        attachmentCollectionView.allowsMultipleSelection = true
        
    }
    
    @IBAction func deleteAttachmentPressed(_ sender: UIButton) {
        
        if let indexpaths = attachmentCollectionView.indexPathsForSelectedItems{
            indexpaths.forEach { index in
                if let cell = attachmentCollectionView.cellForItem(at: index) as? AttachmentCell {
                    AttachmentImageArray.removeAll { uiImage in
                        
                        cell.attachmentImage.image == uiImage
                    }
                }else{
                    print("here")
                }
                
            }
            
        }
        attachmentCollectionView.reloadData()
        
    }
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        tableView.reloadData()
        attachmentCollectionView.reloadData()
    }
    
    @IBAction func SendPressed(_ sender: UIButton) {
        
        
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
        
        textView.text = placeholder
        textView.textColor = UIColor.lightGray
        
        // here is code to store a new post on firebase
        
    }
    
}

//MARK: - imagePickerControllerDelegate
extension HomeViewController: PHPickerViewControllerDelegate{
    
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
        
        if AttachmentImageArray.count == 10{
            
            let alret = UIAlertController(title: "No More Images" , message: "total images you can upload in a single post is 10", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "close", style: .cancel) { action in
                // what will happen when user will tap on add button
            }
            
            alret.addAction(action)
            present(alret, animated: true,completion: nil)
            
        }else{
            AttachmentImageArray.append(pickedImage)
            attachmentCollectionView.reloadData()
        }
        
    }
    
}


//MARK: - Attachment uiCollectionView Datasource

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AttachmentImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = attachmentCollectionView.dequeueReusableCell(withReuseIdentifier: K.attachmentImageIdentifier, for: indexPath) as! AttachmentCell
        
        cell.attachmentImage.image = AttachmentImageArray[indexPath.row]
        return cell
    }
    
    
}

//MARK: - Attachment uiCollectionView Delegate
extension HomeViewController: UICollectionViewDelegate{
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        deleteAttachmentButton.isHidden = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if attachmentCollectionView.indexPathsForSelectedItems?.count == 0{
            
            deleteAttachmentButton.isHidden = true
            
        }
        
    }
    
}







