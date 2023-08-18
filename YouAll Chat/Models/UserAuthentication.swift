//
//  UserAuthentication.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//

import Foundation
import Firebase

class UserAuthentication{
    var user : User?
    
    func verifyUser(_ phoneNo:String){
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNo, uiDelegate: nil) { verificationID, error in
                if error != nil {
                    fatalError("phone no cannot be verified...check proper formate and handle this for nil phone no")
                    
                }
                
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
    }
    
    func checkLogin() -> Bool{
        if Auth.auth().currentUser != nil{
            //print(user.phoneNumber!)
            return true
        }else{
            
            return false
        }
    }
    
    func logIn(_ OTP:String? = "")-> AuthCredential{
        
        
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            fatalError("failed to get verification id from userDefaults")
        }
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ,
            verificationCode: OTP!)
        
        return credential
    }
    
    func getUser()->User{
        
        return self.user!
    }
    
    
    func logOut(){
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
