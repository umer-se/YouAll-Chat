//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//

import UIKit
import MultipleImageView

class HomeViewController : UIViewController{

    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    let userAutentication = UserAuthentication()
    let postSource = Post()
    
     var sources: [MultipleImageView.Source] = [
        .uiimage(UIImage(systemName: "a.book.closed")!),
        .uiimage(UIImage(systemName: "a.book.closed")!),
        .uiimage(UIImage(systemName: "a.book.closed")!),
        .uiimage(UIImage(systemName: "a.book.closed")!),
        .uiimage(UIImage(systemName: "a.book.closed")!),
        .uiimage(UIImage(systemName: "a.book.closed")!)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "Post" , bundle: nil), forCellReuseIdentifier:"postIdentifier")
        
        
    }
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        tableView.reloadData()
        
        
    }
    @IBAction func logOutPressed(_ sender: Any) {
        
        userAutentication.logOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
//MARK: - tableView datasource

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postIdentifier" , for: indexPath) as! Post
    
        cell.userImage.image = UIImage(systemName: "a.book.closed")
        
       // cell.multipleImageView.sources = sources
        
        return cell
    }
    
    
}








