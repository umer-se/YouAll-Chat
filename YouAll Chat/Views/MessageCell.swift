//
//  MessageCell.swift
//  YouAll Chat
//
//  Created by Umer on 23/08/2023.
//

import UIKit

class messageCell : UITableViewCell{
    
    @IBOutlet weak var otherView: UIStackView!
    
    @IBOutlet weak var selfView: UIStackView!
    
    @IBOutlet weak var messageBubble: UIView!
    
    @IBOutlet weak var messageBody: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 6
    }
    
    
    func setupRow(sender:String,messageBody: String){
        
        if sender == "self"{
            otherView.isHidden = true
        }else {
            selfView.isHidden = true
        }
        
        self.messageBody.text = messageBody
        
    }
    
    override func prepareForReuse() {
        otherView.isHidden = false
        selfView.isHidden = false
        messageBody.text = ""
        
    }
    
    
    
}
