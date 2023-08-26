//
//  Constants.swift
//  YouAll Chat
//
//  Created by Umer on 09/08/2023.
//

import Foundation
struct P{
    static let PostCollection = "Posts"
    static let Postsender = "sender"
    static let PostBody = "postbody"
    static let dateField = "date"
    static let postImages = "postImages"
    static let postID = "postID"
    static let commentCollection = "Comments"
    static let commentId = "commentID"
    static let commentBody = "commentBody"
    static let commentSender = "commentSender"
    static let commentDate = "date"
    static let commentTimeStamp = "commentTimeStamp"
    static let commenterProfileImage = "Sender ProfileImage"
    static let postSenderImage = "profilePicture" 
}

struct Conversation{
    static let recieverPicture = "recieverPicture"
    static let createrPicture = "createrPicture"
    static let Collection = "Conversations"
    static let RecieverID = "ConversationWith"
    static let CreaterID = "ConversationStarter"
    static let ID = "ConversationID"
    static let user = "User"
    static let recieverName = "RecieverName"
    static let createrName = "CreaterName"
    static let Participants = "ConversationParticipations"
    static let time = "last Message Time"
    static let lastMessage = "LastMessage"
}

struct FirebaseUser{
    static let UserColletion = "Users"
    static let Name = "Name"
    static let PhoneNo  = "Phone NO"
    static let Email  = "Email"
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
    static let MessageCell = "MessageCell"
     
}
struct Global{
    static let collection = "Global"

    
}
