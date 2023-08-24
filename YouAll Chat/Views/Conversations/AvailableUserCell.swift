//
//  AvailableUserCell.swift
//  YouAll Chat
//
//  Created by Umer on 22/08/2023.
//

import UIKit

class AvailableUserCell: UITableViewCell{
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    func setupRow(username :String){
        
        userName.text = username
    }
    
    override func prepareForReuse() {
        userName.text = ""
    }
}
