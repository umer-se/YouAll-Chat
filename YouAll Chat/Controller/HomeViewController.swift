//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//

import UIKit
import PhotosUI

class HomeViewController : UIViewController{
    
    @IBOutlet weak var postTextField: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    
    let placeholder = "Whats on your Mind"
    let userAutentication = UserAuthentication()
    let postSource = Post()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTextField.text = placeholder
        postTextField.textColor =  UIColor.lightGray
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "Post" , bundle: nil), forCellReuseIdentifier:"postIdentifier")
        
    }
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        tableView.reloadData()
    }
    
    
    @IBAction func insertImagePressed(_ sender: UIButton) {
        
      
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 10
        configuration.filter = PHPickerFilter.images
        let imagePicker = PHPickerViewController(configuration: configuration)

        imagePicker.delegate = self
        
        present(imagePicker, animated: true,completion: nil)

        
    }
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        
        userAutentication.logOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
//MARK: - tableView datasource

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postSource.images.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postIdentifier" , for: indexPath) as! Post
        
        return cell;
        
    }
    
}

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
        
        if textViewHeight.constant < 40{
            textViewHeight.constant = textView.sizeThatFits(CGSize(width: textView.frame.width, height:.infinity )).height - 30
        }
       
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = placeholder
                textView.textColor = UIColor.lightGray
            }
            textViewHeight.constant = 0.0
            print(textView.text!)
        }
        
}

//MARK: - imagePickerControllerDelegate
extension HomeViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true,completion: nil)
        
        for result in results {
              result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                 if let image = object as? UIImage {
                    DispatchQueue.main.async {
                       // Use UIImage
                        self.insertImage(image)
                       print("Selected image: \(image)")
                    }
                 }
              })
           }
        
    }

    func insertImage(_ image:UIImage) {
        let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.orange
                    ]
        let mystring = NSMutableAttributedString(string: "image\n", attributes: attributes)
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        //attachment.setImageHeight(height: 200)
        let imageString = NSAttributedString(attachment: attachment)
        
        /// at is current cursor position
       // self.postTextField.textStorage.insert(imageString, at: self.postTextField.selectedRange.location)
        mystring.append(imageString)
        mystring.append(NSAttributedString(string: "\nTHE END!!!", attributes: attributes))
        
        // set the text for the UITextView
        postTextField.attributedText = mystring;
        
    }
    




}







