//
//  HomeViewController.swift
//  YouAll Chat
//
//  Created by Umer on 05/08/2023.
//

import UIKit
import ImageViewer_swift



class HomeViewController : UIViewController{

    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    let userAutentication = UserAuthentication()
    let postSource = Post()
    
    var sources: [UIImage] = [
        UIImage(systemName: "a.book.closed")!,
        UIImage(systemName: "a.book.closed")!,
        UIImage(systemName: "a.book.closed")!,
        UIImage(systemName: "a.book.closed")!,
        UIImage(systemName: "a.book.closed")!,
        UIImage(systemName: "a.book.closed")!,
        UIImage(systemName: "a.book.closed")!,
        UIImage(systemName: "a.book.closed")!
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "Post" , bundle: nil), forCellReuseIdentifier:"postIdentifier")
        //
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        
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
    
        //cell.setupMultiImagesView()
        //cell.multipleImagesView.setupImageViewer(urls: cell.images,options: [.contentMode(.center)])
        cell.setupWith(name: "Person \(indexPath.row)",
                       content: "Person \(indexPath.row) said this is a great demo, if you like it, please give me a 'star' or fork the project. I will continue making some more Liberary for you.",
                       imageArray:  cell.images[indexPath.row])
        return cell;
        
        
        //cell.iconImageView.image = UIImage(systemName: "a.book.closed")
        
 
        
        return cell
    }
    
    
}








