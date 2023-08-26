//
//  AvailableUserCell.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit
import Kingfisher


class AvailableUserCell: UITableViewCell{
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var phoneNo: UILabel!
    
    func setupRow(username :String, image: String ,phoneNo: String ){
        
        userImage.kf.setImage(with: URL(string: image))
        userName.text = username
        self.phoneNo.text = phoneNo
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRound(image: userImage)
    }
    
    override func prepareForReuse() {
        userName.text = ""
    }
    
    func makeRound(image:UIImageView){
        
        image.layer.borderWidth = 1
            image.layer.masksToBounds = false
            image.layer.borderColor = UIColor.black.cgColor
            image.layer.cornerRadius = image.frame.height/2
            image.clipsToBounds = true
    }
}
