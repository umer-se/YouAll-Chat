//
//  Post.swift
//  YouAll Chat
//
//  Created by Umer on 07/08/2023.
//

import UIKit
//import JNMultipleImages
import FTImageViewer


class Post : UITableViewCell{
    
    //MARK: - IBOutlets
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var postDescription: UILabel!
    
    @IBOutlet weak var imageGridView: FTImageGridView!
    
    @IBOutlet weak var imageGridHeight: NSLayoutConstraint!
    
    
    let images: [[String]]  = [
      
        ["https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",
         "https://i.pinimg.com/originals/c2/19/53/c21953f3ad4a17d96eb80d649bc8149b.jpg",
         "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg",
         "https://images.pexels.com/photos/514241/pexels-photo-514241.jpeg?w=1260&h=750&dpr=2&auto=compress&cs=tinysrgb"],
        
        
        [ "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg", "https://i.pinimg.com/736x/53/62/a9/5362a940ab654152d8411b0d2f56d874--sunrise-pictures-nature-pictures.jpg",
          "https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg"],
        
        
        [ "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg",
          "https://i.pinimg.com/736x/53/62/a9/5362a940ab654152d8411b0d2f56d874--sunrise-pictures-nature-pictures.jpg"],
        
        
        ["https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg","https://i.pinimg.com/736x/53/62/a9/5362a940ab654152d8411b0d2f56d874--sunrise-pictures-nature-pictures.jpg",
         "https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg","https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg","https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",]]
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
    
    
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        
        
    }
    
    func setupWith(name: String, content: String, imageArray: [String]) {
        if imageArray.count > 0 {
            if let url = URL(string: imageArray[0]) {
                self.iconImageView.kf.setImage(with: url) //set the user image
            }
        }
        
        self.name.text = name
        self.postDescription.text = content
        
        let gridWidth = UIScreen.main.bounds.size.width
       
        
       
        // get height for the image grid
        imageGridHeight.constant = FTImageGridView.getHeightWithWidth(gridWidth, imgCount: 2)
        
        // show images in grid
        imageGridView.showWithImageArray(imageArray) { (buttonsArray, buttonIndex) in
            // preview images with one line of code
            FTImageViewer.showImages(imageArray, atIndex: buttonIndex, fromSenderArray: buttonsArray)
        }
    }
    
    
}



