//
//  ConversationCell.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit
import Kingfisher

class ConversationCell: UITableViewCell{
    
    @IBOutlet weak var recieverProfileImage: UIImageView!
    
    @IBOutlet weak var recieverName: UILabel!
    
    @IBOutlet weak var recieverLastMessage: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
    func setupRow(recieverName:String, profileImage: String ){
        self.recieverName.text = recieverName
        self.recieverProfileImage.kf.setImage(with: URL(string: profileImage))
        
    }
    
    override func prepareForReuse() {
        recieverName.text = ""
        recieverLastMessage.text = ""
        time.text = ""
    }
    
}
