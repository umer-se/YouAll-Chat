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
    
    func setupRow(sender: String,comment:String){
        
        userName.text = sender
        commentBody.text = comment
        
    }
    override func prepareForReuse() {
        userName.text = ""
        commentBody.text = ""
    }
}

