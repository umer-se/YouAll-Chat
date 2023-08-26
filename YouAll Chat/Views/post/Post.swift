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
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var postDescription: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var commentButton: UIButton!
    
    
    //MARK: - Variables
    
    var buttonDelegate : postInteractionDelegate?
    
    var pictureIndex:Int?
    let collectionCell = CollectionCell()
    let postImageCollection = PostImageCollectionView()
    var postID = "123"
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
        
        postImageCollection.delegate = self
        
        let whiteView = UIView(frame: bounds)
        whiteView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectedBackgroundView = whiteView
        
        makeRound(image: profileImageView)
    }
    
    func setupRow(postID: String, sender :String ,postBody: String , postImages: [String],time: String,profileimage:String ){
        self.name.text = sender
        self.postDescription.text = postBody
        self.postID = postID
        self.time.text = time
        postImageCollection.images = postImages
        profileImageView.kf.setImage(with: URL(string: profileimage))
        
        if postImages.isEmpty{
            collectionView.isHidden = true
        }else{
            collectionView.isHidden = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func makeRound(image:UIImageView){
        
        image.layer.borderWidth = 1
            image.layer.masksToBounds = false
            image.layer.borderColor = UIColor.black.cgColor
            image.layer.cornerRadius = image.frame.height/2
            image.clipsToBounds = true
    }
    

    //MARK: - IBActions
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        
        buttonDelegate?.likePressed(id: postID)
        //print(postID)
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{
            sender.setTitle("UnLike", for: .selected)
            sender.setImage(UIImage(systemName: "hand.thumbsdown"), for: .selected)
        }else{
            sender.setTitle("Like", for:.normal)
            sender.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
        
    }
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        
        buttonDelegate?.commentPresssed(id: postID)
    }    
}

extension Post: PostImageDelegate{
    func imageTapped(index: Int) {
        print("image \(index) tapped")
    }
    
    
    
}

