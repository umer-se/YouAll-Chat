//
//  Post.swift
//  YouAll Chat
//
//  Created by Umer on 07/08/2023.
//

import UIKit
import MultipleImageView



class Post : UITableViewCell{
    
    //MARK: - IBOutlets
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var postDescription: UILabel!
    
    @IBOutlet weak var multipleImageView: UIView!{
        didSet {
            multipleImageView.layer.cornerRadius = 20
            multipleImageView.layer.masksToBounds = true
           // multipleImageView.delegate = self
        }
    }
    
    
    
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        //
//        multipleImageView.sources = sources
//        multipleImageView.reloadData()
        //
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
    
    
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        
        
    }
    
}

extension Post : MultipleImageViewDelegate{
    
    func multipleImageViewShouldGetImage(_ imageView: UIImageView, sourceForURL url: URL, index: Int) {
        
        //multipleImageView.delegate = self
       
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
            task.resume()
        }
    }

    func multipleImageViewDidSelect(_ imageView: UIImageView, index: Int) {
        print("Tapped index: \(index)")
    }
}


