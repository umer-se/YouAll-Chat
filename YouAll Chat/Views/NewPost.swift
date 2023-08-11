//
//  NewPost.swift
//  YouAll Chat
//
//  Created by Umer on 10/08/2023.
//

import UIKit


protocol NewPostDelegat: AnyObject {
    func pickImage()
}

class NewPost : UITableViewCell{
    
    weak var delegate: NewPostDelegat?
    
    @IBOutlet weak var newPostText: UITextView!
    
    @IBOutlet weak var attachmentView: UIStackView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    @IBAction func imageAttachmentButtonPressed(_ sender: UIButton) {
        
        delegate?.pickImage()
        
    }
    
}



