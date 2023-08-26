//
//  ProfileViewController.swift
//  YouAll Chat
//
//  Created by Umer on 24/08/2023.
//

import UIKit
import PhotosUI
import Firebase
import FirebaseStorage
import Kingfisher

class ProfileVC: UIViewController{
    //MARK: - IBOutslets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Variables
    
    let db = Firestore.firestore()
    let userAuthentication = UserAuthentication()
    var imageUrl :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProfile()
    }
    
    //MARK: - IBActions
    @IBAction func submitpressed(_ sender: UIButton) {
        if let userName = nameTextField.text{
            saveName(name: userName)
        }
        if let profileImage = profilePicture.image{
            saveProfileImage(image :profileImage)
        }
        if let email = emailTextField.text{
            saveEmail(email: email)
        }
        
        self.userAuthentication.saveUser()
        
        performSegue(withIdentifier: "postScreen", sender: self)
                
    }
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        configuration.filter = PHPickerFilter.images
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = self
        present(imagePicker, animated: true,completion: nil)
        
    }
    
}
//MARK: - PhPickerViewController Delegate
extension ProfileVC:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true,completion: nil)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let pickedImage = object as? UIImage {
                    DispatchQueue.main.async {
                        // Use UIImage
                        self.profilePicture.image = pickedImage
                    }
                }
            })
        }
    }
    
}

extension ProfileVC{
    
    func saveName(name:String){
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
            if error != nil{
                print("error saving Name \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func saveProfileImage(image :UIImage){
        
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
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.photoURL = downloadURL
                        changeRequest?.commitChanges { error in
                            if error != nil {
                                print("error Saving profile picture")
                            }
                            self.userAuthentication.saveUserProfilePicture()
                        }
                        
                    }
                    
                }
            }
            )}// uploadTask end
    }
    func saveEmail(email:String){
        
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            if error != nil {
                print("error saving email \(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    
    func loadProfile(){
        if let user = Auth.auth().currentUser{
            
            if  user.metadata.lastSignInDate == user.metadata.creationDate{
                print("new user")
                
            }else{
                self.nameTextField.text = user.displayName
                self.emailTextField.text = user.email
                self.profilePicture.kf.setImage(with: user.photoURL)
            }
        }
    }
}



