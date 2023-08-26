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
    var addConversationDelegate : UpdateTableDelegate?
    
    let db = Firestore.firestore()
    var users:[UserModel] = []
    
    func getallUsersOnNetwork(){
        db.collection(FirebaseUser.UserColletion).addSnapshotListener { QuerySnapshot, error in
            
            if error != nil{
                print("error during fetching all users from database \(String(describing: error?.localizedDescription))")
            }
            else
            {
                self.users = []
                for document in QuerySnapshot!.documents{
                    
                    let user = document.data()
                    let userModel = UserModel(Name: (user[FirebaseUser.Name] as? String ?? ""),
                                              PhoneNo: (user[FirebaseUser.PhoneNo] as? String ?? ""),
                                              Email: (user[FirebaseUser.Email] as? String ?? ""),
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
        
        let selectedUserID = selectedItem.uid
        
        checkIfConversationExists(selectedUserID,selectedItem)
        
        
    }
    
    
    
    
    func checkIfConversationExists(_ selectedUserID: String,_ selectedUser : UserModel) {
        var flag = true
        let currentUser = (Auth.auth().currentUser)!
        
        db.collection(Conversation.Collection).getDocuments { QuerySnapshot, error in
            if error != nil{
                print("error during fetching all users from database \(String(describing: error?.localizedDescription))")
            }
            else
            {
                if QuerySnapshot?.documents.count == 0{
                    flag = false
                }
                
                for document in QuerySnapshot!.documents{
                    
                    let conversation = document.data()
                    if let creater = conversation[Conversation.CreaterID], let with = conversation [Conversation.RecieverID] {
                        if creater as! String == currentUser.uid && with as! String == selectedUserID{
                            print("conversation already exists.")
                            flag = true
                            break
                        }else{
                            flag = false
                        }
                    }
                }
                if !flag {
                    self.addConversation(currentUser: currentUser,selectedUser: selectedUser)
                }
            }
        }
    }
    func addConversation(currentUser: User,selectedUser : UserModel) {
        
        
        
        let conversationModel = ConversationModel(recieverID: selectedUser.uid, createrID: currentUser.uid, recieverName: selectedUser.Name ?? "No Name", CreaterName: currentUser.displayName ?? "No Name" , conversationID: "", createrPicture: currentUser.photoURL!.absoluteString, recieverPicture: selectedUser.profilePicture)
        
        let dbRef = db.collection(Conversation.Collection).document()
        
        dbRef.setData([Conversation.RecieverID: conversationModel.recieverID,
                       Conversation.CreaterID: conversationModel.createrID,
                       Conversation.ID: dbRef.documentID,
                       Conversation.recieverName : conversationModel.recieverName ,
                       Conversation.createrName : conversationModel.CreaterName,
                       Conversation.recieverPicture: conversationModel.recieverPicture,
                       Conversation.createrPicture: conversationModel.createrPicture
                      ]) { error in
            if let e = error{
                print("there was an issue saving data to fibase---\(e.localizedDescription)")
            }else{
                print("conversation with selected user is started")
                DispatchQueue.main.async {
                    self.addConversationDelegate?.updateTable()
                }
                
                self.setConversationPaticipant(conversationID: dbRef.documentID, selectedUser: selectedUser.uid, currentUser: currentUser.uid)
                
            }
        }
    }
    
    func setConversationPaticipant(conversationID:String, selectedUser:String, currentUser:String){
        
        db.collection(Conversation.Participants).document().setData([Conversation.ID:conversationID,Conversation.user: selectedUser]){ error in
            if let e = error{
                print("there was an issue saving data to fibase---\(e.localizedDescription)")
            }else{
                print("conversation participation for selected user is added")
                DispatchQueue.main.async {
                    self.addConversationDelegate?.updateTable()
                }
            }
            
        }
        
        
        db.collection("ConversationParticipations").document().setData([Conversation.ID:conversationID,Conversation.user: currentUser]){ error in
            if let e = error{
                print("there was an issue saving data to fibase---\(e.localizedDescription)")
            }else{
                print("conversation participation for current user is added")
                DispatchQueue.main.async {
                    self.addConversationDelegate?.updateTable()
                }
            }
            
        }
        
    }
}
