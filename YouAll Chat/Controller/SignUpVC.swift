//
//  SignUpViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//

import UIKit

class SignUpVC : UIViewController{
    
    //MARK: - IBOutlets
    @IBOutlet weak var oTPView: UIView!
    @IBOutlet weak var phoneNoField: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var oTPField: UITextField!
    
    
    
    //MARK: - Variables
    let userAuthentication: UserAuthentication = UserAuthentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAuthentication.userAuthDelegate = self
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if userAuthentication.checkLogin()  {
            logInView()
        }
    }
    
    
    @IBAction func continueForPhoneNOPressed(_ sender: UIButton) {
        if let phoneNo = phoneNoField.text {
            
            userAuthentication.verifyUser(phoneNo)
            
        }
    }
    @IBAction func confirmForOTPPressed(_ sender: UIButton) {
        
        if let OTP = oTPField.text {
            userAuthentication.login(OTP: OTP)
            
           
        }
    }
}
extension SignUpVC:UserAuthenticationDelegate{
    func logInView(){
        
        self.performSegue(withIdentifier: "homeScreen", sender: self)
    }
    
    
}

