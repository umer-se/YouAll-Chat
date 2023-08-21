//
//  CommentVC.swift
//  YouAll Chat
//
//  Created by Umer on 21/08/2023.
//

import UIKit

class CommentVC : UIViewController{
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var postID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(postID)
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        
    }
    
    
}
