//
//  Post.swift
//  YouAll Chat
//
//  Created by Umer on 07/08/2023.


import UIKit
import Kingfisher
import Firebase

class PostCell : UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    //MARK: - Variables
    
    var buttonDelegate : postInteractionDelegate?
    
    var pictureIndex:Int?
    let collectionCell = CollectionCell()
    let postImageCollection = PostImageCollectionView()
    var postID :String?
    var images: [String]  = []
    
    
    private var shouldChange = false
    
    var buttonTitle: String {
        return shouldChange ? "Close" : "Comment"
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
    
    func setupRow(postItem: PostModel){
        
        self.name.text = postItem.sender
        self.postDescription.text = postItem.postBody
        self.postID = postItem.postID
        self.time.text = postItem.time
        postImageCollection.images = postItem.postImages.count > 0 ? postItem.postImages : []
        profileImageView.kf.setImage(with: URL(string: postItem.profileImage))
        
        if postItem.postImages.isEmpty{
            collectionView.isHidden = true
        }else{
            collectionView.isHidden = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        if let userID = Auth.auth().currentUser?.uid{
            
            if postItem.LikeBy.contains(userID){
                likeButton.setTitle("UnLike", for: .normal)
                likeButton.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
            }
            else{
                likeButton.setTitle("Like", for:.normal)
                likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            }
        }
        
    }
    
    override func prepareForReuse() {
        name.text = ""
        time.text = ""
        profileImageView.image = UIImage(named: "person.fill")
        likeButton.isSelected = false
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
        
        sender.isSelected = !sender.isSelected
        
        if let id = postID{
            if sender.isSelected && sender.titleLabel?.text == "Like" {
                sender.setTitle("UnLike", for: .selected)
                sender.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
                buttonDelegate?.likePressed(ID: id,For: "like")
            }else{
                sender.setTitle("Like", for:.normal)
                sender.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
                buttonDelegate?.likePressed(ID: id,For: "Unlike")
            }
        }
        
    }
        
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        
        if let id = postID{
            buttonDelegate?.commentPresssed(id: id)
        }
     
    }
}

//MARK: - PostImage Delegate

extension PostCell: PostImageDelegate{
    
    func imageTapped(index: Int) {
        print("image \(index) tapped")
        //postImageCollection.images
        
    }
    
    
    
}

