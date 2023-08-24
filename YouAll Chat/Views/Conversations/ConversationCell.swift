//
//  ConversationCell.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit

class ConversationCell: UITableViewCell{
    
    @IBOutlet weak var recieverProfileImage: UIImageView!
    
    @IBOutlet weak var recieverName: UILabel!
    
    @IBOutlet weak var recieverLastMessage: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
//    func setupCell(reciever :String,lastMessage :String, time: Date ){
//
//        recieverName.text = reciever
//        recieverLastMessage.text = lastMessage
//        recieverProfileImage.image = UIImage(systemName: "person.fill")
//        self.time.text = time.formatted()
//    }
    func setupRow(conversationWith:String){
        recieverName.text = conversationWith
        
    }
    
    override func prepareForReuse() {
        recieverName.text = ""
        recieverLastMessage.text = ""
        time.text = ""
    }
    
}
