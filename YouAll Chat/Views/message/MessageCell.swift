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
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageBody: UILabel!
    
    @IBOutlet weak var otherImageView: UIImageView!
    @IBOutlet weak var selfImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 6
        makeRound(image: otherImageView)
        makeRound(image: selfImageView)
    }
    
    
    func setupRow(sender:String,message: MessageModel ){
        
        if sender == "self"{
            otherView.isHidden = true
            senderName.text = message.sender
            selfImageView.kf.setImage(with: URL(string: message.senderpicture))
        }else{
            selfView.isHidden = true
            recipientName.text = message.recipient
            otherImageView.kf.setImage(with: URL(string: message.recipientPicture))
        }
        
        self.messageBody.text = message.content
        
    }
    func setupGlobalmessage(sender:String,message: GlobalMessageModel ){
        
        if sender == "self"{
            senderName.text = message.sender
            otherView.isHidden = true
            selfImageView.kf.setImage(with: URL(string: message.senderProfilePicture))

        }else{
            selfView.isHidden = true
            recipientName.text = message.sender
            otherImageView.kf.setImage(with: URL(string: message.senderProfilePicture))
        }
        
        self.messageBody.text = message.content
        
    }
    
    override func prepareForReuse() {
        otherView.isHidden = false
        selfView.isHidden = false
        messageBody.text = ""
        
    }
    
    func makeRound(image:UIImageView){
        
        image.layer.borderWidth = 1
            image.layer.masksToBounds = false
            image.layer.borderColor = UIColor.black.cgColor
            image.layer.cornerRadius = image.frame.height/2
            image.clipsToBounds = true
    }
    
    
    
}
