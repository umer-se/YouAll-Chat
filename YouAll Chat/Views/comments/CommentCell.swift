//
//  CommentCell.swift
//  YouAll Chat
//
//  Created by Umer on 18/08/2023.
//

import UIKit


class CommentCell : UITableViewCell{
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentBody: UILabel!
    
   // var delegate: UpdateTableDelegate?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        makeRound(image: profilePic)
    }
    
    func setupRow(comment: CommentModel){
        
        userName.text = comment.sender
        commentBody.text = comment.commentBody
        profilePic.kf.setImage(with: URL(string: comment.userImage))
        
    }
    override func prepareForReuse() {
        userName.text = ""
        commentBody.text = ""
    }
    
    func makeRound(image:UIImageView){
        
        image.layer.borderWidth = 1
            image.layer.masksToBounds = false
            image.layer.borderColor = UIColor.black.cgColor
            image.layer.cornerRadius = image.frame.height/2
            image.clipsToBounds = true
    }
}

