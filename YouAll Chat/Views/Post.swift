//
//  Post.swift
//  YouAll Chat
//
//  Created by Umer on 07/08/2023.
//

import UIKit
import Kingfisher

class Post : UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var postDescription: UILabel!
    
    @IBOutlet weak var customCollectionView: UICollectionView!
    
    
    
    //MARK: - Variables
    var pictureIndex:Int?
    let collectionCell = CollectionCell()
    let collectionLastCell = CollectionLastCell()
    
    let images: [String]  = [
        
        "https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",
        "https://i.pinimg.com/originals/c2/19/53/c21953f3ad4a17d96eb80d649bc8149b.jpg",
        "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg",
      // "https://images.pexels.com/photos/514241/pexels-photo-514241.jpeg?w=1260&h=750&dpr=2&auto=compress&cs=tinysrgb",
        //  "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg",
      //     "https://i.pinimg.com/736x/53/62/a9/5362a940ab654152d8411b0d2f56d874--sunrise-pictures-nature-pictures.jpg",
        //"https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",
        //   "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg",
        //     "https://i.pinimg.com/736x/53/62/a9/5362a940ab654152d8411b0d2f56d874--sunrise-pictures-nature-pictures.jpg",
        //     "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg",
        //     "https://i.pinimg.com/736x/53/62/a9/5362a940ab654152d8411b0d2f56d874--sunrise-pictures-nature-pictures.jpg",
        //     "https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",
        //     "https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",
        //     "https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCollectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: collectionCell.Identifier)
        customCollectionView.register(UINib(nibName: "CollectionLastCell", bundle: nil), forCellWithReuseIdentifier: collectionLastCell.identifier)
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        
    }
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        
    }
}


//MARK: - CollectionView DataSource

extension Post: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images.count < 4{
            return images.count
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            return CGSize(width:width / 2 , height: height)
        
        case 3:
            if indexPath.row == 2{
                return CGSize(width:width , height: height / 2)
            }
            return CGSize(width:(width / 2)-1 , height: height / 2)
        
        default:
            return CGSize(width:width / 2 , height: height / 2)
         
            }
    }
    

}
