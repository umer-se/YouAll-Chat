//
//  SignUpViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//

import UIKit
import Firebase

class SignUpViewController : UIViewController{
    
    //MARK: - IBOutlets
    @IBOutlet weak var oTPView: UIView!
    @IBOutlet weak var phoneNoField: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var oTPField: UITextField!
    
    
    
    //MARK: - Variables
    let userAuthentication: UserAuthentication = UserAuthentication()
    var user :User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oTPView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if userAuthentication.checkLogin()  {
            logInView()
        }
    }
    
    
    @IBAction func continueForPhoneNOPressed(_ sender: UIButton) {
        if let phoneNo = phoneNoField.text {
            
            userAuthentication.verifyUser(phoneNo)
            oTPView.isHidden = !oTPView.isHidden
            phoneNumberView.isHidden = !phoneNumberView.isHidden
            
        }
    }
    @IBAction func confirmForOTPPressed(_ sender: UIButton) {
        
        
        if let OTP = oTPField.text {
            // doing sign in process here instead of donig it in userAuthentication class because of sync or thread issues after learning more about dispatchques and such  move this block of code to user authentication
            let credential = self.userAuthentication.logIn(OTP)
                Auth.auth().signIn(with: credential) { authResult, error in
                    
                    if let error = error {
                        // handle error properly here
                        print(error)
                    }else{
                        //sign in
                        self.oTPView.isHidden = !self.oTPView.isHidden
                        self.phoneNumberView.isHidden = !self.phoneNumberView.isHidden
                        self.logInView()
                    }
                    
                }
        }
    }
    
    func logInView(){
        self.performSegue(withIdentifier: "homeScreen", sender: self)
    }
    
    
    
    
    
}


