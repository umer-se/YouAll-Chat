//
//  Constants.swift
//  YouAll Chat
//
//  Created by Umer on 09/08/2023.
//

import Foundation
struct Post{
    static let collection = "Posts"
    static let sender = "sender"
    static let senderImage = "profilePicture"
    static let content = "postbody"
    static let date = "date"
    static let images = "postImages"
    static let postID = "postID"
    static let timeStamp = "Time Stamp"
    static let likes = "Likes"
    static let likeBy = "LikeBy"
    
}
struct Comment{
    static let collection = "Comments"
    static let id = "commentID"
    static let content = "Content"
    static let Sender = "Sender"
    static let Date = "Date"
    static let TimeStamp = "TimeStamp"
    static let Image = "Sender ProfileImage"

}


struct Conversation{
    static let recieverPicture = "recieverPicture"
    static let createrPicture = "createrPicture"
    static let collection = "Conversations"
    static let recieverID = "ConversationWith"
    static let createrID = "ConversationStarter"
    static let ID = "ConversationID"
    static let user = "User"
    static let recieverName = "RecieverName"
    static let createrName = "CreaterName"
    static let Participants = "ConversationParticipations"
    static let time = "last Message Time"
    static let lastMessage = "LastMessage"
}

struct FirebaseUser{
    static let colletion = "Users"
    static let name = "Name"
    static let phoneNo  = "Phone NO"
    static let email  = "Email"
    static let id = "UID"
    static let recieverID = "RecieverID"
    static let profilePicture = "ProfilePicture"
}
struct Message{
    static let collection = "Messages"
    static let sender = "Sender Name"
    static let recipient = "Recipient Name "
    static let senderID = "SenderID"
    static let recipientId = "RecipientID"
    static let date = "Time"
    static let content = "Content"
    static let senderPicture = "SenderProfilePicture"
    static let recipientPicture = "RecipientProfilePicture"
    static let timeStamp = "TimeStamp"
    
}


struct K {
    
    static let PostIdentifier = "postIdentifier"
    static let attachmentImageIdentifier = "attachmentCell"
    static let commentsScreen = "comments"
    static let commentCell = "commentCell"
    static let conversationCell = "ConversationCell"
    static let availableUserCell = "AvailableUserCell"
    static let chatView = "ChatView"
    static let messageCell = "MessageCell"
     
}
struct Global{
    static let collection = "Global"

    
}
