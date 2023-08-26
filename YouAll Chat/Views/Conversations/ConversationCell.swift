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
    
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRound(image: recieverProfileImage)
    }
    
    func setupRow(recieverName:String, profileImage: String,time : String ){
        self.recieverName.text = recieverName
        self.recieverProfileImage.kf.setImage(with: URL(string: profileImage))
        self.time.text = time
    }
    
    override func prepareForReuse() {
        recieverName.text = ""
        time.text = ""
    }
    
    
    func makeRound(image:UIImageView){
        
        image.layer.borderWidth = 1
            image.layer.masksToBounds = false
            image.layer.borderColor = UIColor.black.cgColor
            image.layer.cornerRadius = image.frame.height/2
            image.clipsToBounds = true
    }
}
