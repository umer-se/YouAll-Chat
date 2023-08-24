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
    var  avialableDidSelectDelegate : SwitchScreenDelegate?
    
    let db = Firestore.firestore()
    var users:[UserModel] = []
    
    func getallUsersOnNetwork(){
        db.collection(User.UserColletion).addSnapshotListener { QuerySnapshot, error in
            
            if error != nil{
                print("error during fetching all users from database \(String(describing: error?.localizedDescription))")
            }
            else
            {
                self.users = []
                for document in QuerySnapshot!.documents{
                    
                    let user = document.data()
                    let userModel = UserModel(Name: (user[User.Name] as? String ?? ""),
                                              PhoneNo: (user[User.PhoneNo] as? String ?? ""),
                                              Email: (user[User.Email] as? String ?? ""),
                                              uid: user[User.id] as? String ?? "")
                   
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
        cell.setupRow(username: userItem.PhoneNo!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.avialableDidSelectDelegate?.switchScreen()
        }
        
        let selectedUser = users[indexPath.row].uid
            addConversation(selectedUser)
        
       
    }
   
    
    
    func addConversation(_ selectedUserID: String) {
        let currentUser = (Auth.auth().currentUser)!
        
        var conversationModel = ConversationModel(ConversationWith: selectedUserID)
        
        db.collection(Conv.conversationCollection)
            .document(currentUser.uid)
            .setData([Conv.conversationWith: conversationModel.ConversationWith]) { error in
                if let e = error{
                    print("there was an issue saving data to fibase---\(e.localizedDescription)")
                }else{
                    print("conversation with selected user is started")
                    
                    
                }
            }
    }
    
 
}
