//
//  Post.swift
//  YouAll Chat
//
//  Created by Umer on 07/08/2023.


import UIKit
import Kingfisher

class Post : UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var postDescription: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var commentButton: UIButton!
    
    
    //MARK: - Variables
   
    var pictureIndex:Int?
    let collectionCell = CollectionCell()
    let postImageCollection = PostImageCollectionView()
    
    var images: [String]  = []
 
    
    private var shouldCollapse = false
    
    var buttonTitle: String {
        return shouldCollapse ? "Close" : "Comment"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: collectionCell.Identifier)
        collectionView.dataSource = postImageCollection
        collectionView.delegate = postImageCollection
        
        let whiteView = UIView(frame: bounds)
        whiteView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectedBackgroundView = whiteView
        
    }
    
    func setupRow(sender :String ,postBody: String , postImages: [String],time: String ){
        self.name.text = sender
        self.postDescription.text = postBody
       
        self.time.text = time
        postImageCollection.images = postImages
        let url = URL(string: "https://www.freeimages.com/photo/holding-a-dot-com-iii-1411477")
        self.iconImageView.kf.setImage(with: url)
        
        if postImages.isEmpty{
            collectionView.isHidden = true
        }else{
            collectionView.isHidden = false
        }
        
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()

        }
       
    }
    
//    
//    override func prepareForReuse() {
//        self.images.removeAll()
//       
//    }
//    
    //MARK: - IBActions
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        print("like button")
        if sender.isSelected{
            sender.setTitle("UnLike", for: .selected)
            sender.setImage(UIImage(systemName: "hand.thumbsdown"), for: .selected)
            print(isSelected)
        }else{
            sender.setTitle("Like", for:.normal)
            sender.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
        
        
    }
    @IBAction func commentButtonPressed(_ sender: UIButton) {
       
        sender.isSelected = !sender.isSelected
    }
    
   
}
