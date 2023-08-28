//
//  AddConversation.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit
import Firebase


class AvailableUsers: NSObject{
    
    var availableUserDelegate: UpdateTableDelegate?
    var avialableDidSelectDelegate : SwitchScreenDelegate?
    
    
    let db = Firestore.firestore()
    var users:[UserModel] = []
    let addConversation = AddConversation()
    
    
    
    func getallUsersOnNetwork(){
        db.collection(FirebaseUser.colletion).addSnapshotListener { QuerySnapshot, error in
            
            if error != nil{
                print("error during fetching all users from database \(String(describing: error?.localizedDescription))")
            }
            else
            {
                self.users = []
                for document in QuerySnapshot!.documents{
                    
                    let user = document.data()
                    let userModel = UserModel(Name: (user[FirebaseUser.name] as? String ?? ""),
                                              PhoneNo: (user[FirebaseUser.phoneNo] as? String ?? ""),
                                              Email: (user[FirebaseUser.email] as? String ?? ""),
                                              uid: user[FirebaseUser.id] as? String ?? "", profilePicture: user[FirebaseUser.profilePicture] as? String ?? "")
                    
                    if userModel.uid != Auth.auth().currentUser?.uid{
                        self.users.append(userModel)
                    }
                }
                self.availableUserDelegate?.updateTable()
                
            }
        }
    }
    
    
    
}
extension AvailableUsers:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.availableUserCell) as! AvailableUserCell
        
        let userItem = users[indexPath.row]
        // add user image and other user properties here in future
        cell.setupRow(username: userItem.Name ?? "No Name" , image: userItem.profilePicture, phoneNo: userItem.PhoneNo ?? "no phone number" )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.avialableDidSelectDelegate?.switchScreen()
        }
        let selectedItem = users[indexPath.row]
        addConversation.checkIfConversationExists(selectedItem)
    }
}
