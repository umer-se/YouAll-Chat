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

