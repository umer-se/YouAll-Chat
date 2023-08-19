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
    
    @IBOutlet weak var customCollectionView: UICollectionView!
    
    @IBOutlet weak var commentButton: UIButton!
    
    
    //MARK: - Variables
   
    var pictureIndex:Int?
    let collectionCell = CollectionCell()
    let collectionLastCell = CollectionLastCell()
    var images: [String]  = []
 
    
    private var shouldCollapse = false
    
    var buttonTitle: String {
        return shouldCollapse ? "Close" : "Comment"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCollectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: collectionCell.Identifier)
        customCollectionView.register(UINib(nibName: "CollectionLastCell", bundle: nil), forCellWithReuseIdentifier: collectionLastCell.identifier)
        
        
        let whiteView = UIView(frame: bounds)
        whiteView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectedBackgroundView = whiteView
        
    }
    
    func setupRow(sender :String ,postBodey: String , postImages: [String],time: String ){
        self.name.text = sender
        self.postDescription.text = postBodey
        self.time.text = time
        self.images = postImages
        let url = URL(string: "https://www.freeimages.com/photo/holding-a-dot-com-iii-1411477")
        self.iconImageView.kf.setImage(with: url)
        customCollectionView.reloadData()
    }
    
    
    override func prepareForReuse() {
        self.images.removeAll()
       
    }
    
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



//MARK: - CollectionView DataSource

extension Post: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images.count < 4{
            if images.isEmpty{
                collectionView.isHidden = true
            }
            return images.count
        }else{
            return 4
        }

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if images.count == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell.Identifier, for: indexPath as IndexPath) as! CollectionCell
            return cell

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell.Identifier, for: indexPath as IndexPath) as! CollectionCell

            let lastCell = collectionView.dequeueReusableCell(withReuseIdentifier:collectionLastCell.identifier, for: indexPath as IndexPath) as! CollectionLastCell

            if indexPath.row < 3{

                cell.mainView.backgroundColor = UIColor.red
                let url = URL(string: images[indexPath.row])
                cell.mainView.kf.setImage(with: url)
                cell.mainView.contentMode = .scaleAspectFill
                return cell

            }else{
                let count = images.count - 4
                if count == 0{
                    lastCell.photoCounter.isHidden = true
                    lastCell.lastImage.alpha = 1.0
                }
                lastCell.photoCounter.text = String(count)
                let url = URL(string: images[indexPath.row])
                lastCell.lastImage.kf.setImage(with: url)

                lastCell.lastImage.contentMode = .scaleAspectFill
                return lastCell
            }


        }
    }
}
//MARK: - CollectionView Delegate

extension Post: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return getImageSize(indexPath)
    }


    //everything is hardcoded at the moment change it in future
    func getImageSize(_ indexPath:IndexPath)->CGSize{
        let height = customCollectionView.frame.height
        let width = customCollectionView.frame.width

        switch images.count{
        case 1:
            return CGSize(width: width , height: height)

        case 2:
            return CGSize(width:(width / 2)-1 , height: height)

        case 3:
            if indexPath.row == 2{
                return CGSize(width:width , height: (height / 2)-1)
            }
            return CGSize(width:(width / 2)-1 , height: (height / 2)-1)

        case 4...:
            return CGSize(width:(width / 2)-1 , height: (height / 2)-1)

        default:
            customCollectionView.bounds.size.height = 1.0
            return CGSize(width:0, height: 0)
        }
    }
}

