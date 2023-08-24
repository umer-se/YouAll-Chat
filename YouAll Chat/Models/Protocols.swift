//
//  Protocols.swift
//  YouAll Chat
//
//  Created by Umer on 21/08/2023.
//

import Foundation


protocol postInteractionDelegate{
    
    func likePressed(id postID :String)
    func commentPresssed(id postID :String )
}

protocol UserAuthenticationDelegate{
    
    func logInView()
    
}

protocol SwitchScreenDelegate{
    
    func switchScreen()
}
protocol AddConversationDelegate{
    
    func addConversation(_ selectedUserID :String)
}
