//
//  Protocols.swift
//  YouAll Chat
//
//  Created by Umer on 21/08/2023.
//

import Foundation


protocol postInteractionDelegate{
    
    func likePressed(ID :String, For : String)
    func commentPresssed(id postID :String )
}

protocol UserAuthenticationDelegate{
    
    func logInView(newUser :Bool)
    
}

protocol SwitchScreenDelegate{
    
    func switchScreen()
}
protocol AddConversationDelegate{
    
    func addConversation(_ selectedUserID :String)
}

protocol loadMessageDelegate{
    func updateTable()
    func scrollToNewMessage(indexPath : IndexPath)
    
}
protocol DeAttachListener{
    
    func deattachListener(listenerObject: String)
}
