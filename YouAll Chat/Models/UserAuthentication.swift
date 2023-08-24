//
//  UserAuthentication.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//




import Foundation
import Firebase

class UserAuthentication{
    
    var userAuthDelegate: UserAuthenticationDelegate?
    let db = Firestore.firestore()
    
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
       if Auth.auth().currentUser != nil {
            return true
        }else{
            return false
        }
    }
    
    func GetAuthCredential(_ OTP:String? = "")-> AuthCredential{

        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            fatalError("failed to get verification id from userDefaults")
        }
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ,
            verificationCode: OTP!)
        
        return credential
    }
    
    func login(OTP:String){
        
        let credential = self.GetAuthCredential(OTP)
        Auth.auth().signIn(with: credential) { authResult, error in
            
            if let error = error {
                // handle error properly here
                print(error)
            }else{
                //sign in
                self.saveUser(firebaseUser: Auth.auth().currentUser!)
                self.userAuthDelegate?.logInView()
            }
        }
    }
    
    func logOut(){
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func saveUser(firebaseUser : FirebaseAuth.User){
        
        let userName = firebaseUser.displayName ?? "no name"
        let phoneNo = firebaseUser.phoneNumber ?? "no Phone number"
        let email = firebaseUser.email ?? " no email"
        let uid = firebaseUser.uid
        db.collection(User.UserColletion).document(uid).setData([User.id : uid ,
                                                                 User.Name:userName,
                                                                 User.PhoneNo : phoneNo,
                                                                 User.Email: email], merge: true)
        
    }
}
