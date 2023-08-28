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
    
    func GetAuthCredential(_ OTP:String? = "123456")-> AuthCredential{
        
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
                
                
                if let isNewUser: Bool = authResult?.additionalUserInfo?.isNewUser {
                    if isNewUser {
                        self.userAuthDelegate?.logInView(newUser: true)
                    }else{
                        self.userAuthDelegate?.logInView(newUser: false)
                    }
                }
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
    
    func saveUser(){
        
        if let firebaseUser = Auth.auth().currentUser{
            let userName = firebaseUser.displayName ?? "no name"
            let phoneNo = firebaseUser.phoneNumber ?? "no Phone number"
            let email = firebaseUser.email ?? " no email"
            let uid = firebaseUser.uid
            db.collection(FirebaseUser.colletion).document(uid).setData([FirebaseUser.id : uid ,
                                                                             FirebaseUser.name:userName,
                                                                     FirebaseUser.phoneNo : phoneNo,
                                                                     FirebaseUser.email: email], merge: true)
            
        }
        
    }
    func saveUserProfilePicture(){
        if let firebaseUser = Auth.auth().currentUser{
            let profilePicture = firebaseUser.photoURL
            let uid = firebaseUser.uid
            db.collection(FirebaseUser.colletion).document(uid).setData([
                FirebaseUser.profilePicture:profilePicture!.absoluteString], merge: true)
        }
    }
    
    func reauthenticateUser(credential :AuthCredential){
        
        let user = Auth.auth().currentUser
        // get user to login again here
        
        //let credential = GetAuthCredential()
        
        
        user?.reauthenticate(with: credential,completion: { authResult, error in
            
            if let error = error {
                print("error during reauthentication\(error.localizedDescription)")
            } else {
                // User re-authenticated.
            }
            
        })
        
    }
    
}
