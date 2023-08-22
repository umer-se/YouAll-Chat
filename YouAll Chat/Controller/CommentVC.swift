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
    let commentsRef = LoadComments()
    let newCommentRef = AddComments()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = commentsRef
        tableView.delegate = commentsRef
        
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: K.commentCell)
        
        print(postID)
        commentsRef.getCommentsForPostWith(postID: postID)
        commentsRef.commnetDelegate = self
        
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        if let text = textView.text{
            self.newCommentRef.addComment(comment: text,id: postID)
        }
        
        
        
    }
    
    
}
extension CommentVC: UpdateTableDelegate{
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.commentsRef.comments.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
       
    }
    
    
    
}
