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
    
    //    var imageArray : [String] = []{
    //            didSet {
    //                let gridWidth = UIScreen.main.bounds.size.width - 56 - 8
    //
    //                // get height for the image grid
    //                imageGridHeight.constant = FTImageGridView.getHeightWithWidth(gridWidth, imgCount: imageArray.count)
    //
    //                self.setNeedsLayout()
    //            }
    //        }
    
    
    let images: [[String]]  = [
        //        URL(string: "https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg")!,
        //        URL(string: "https://i.pinimg.com/originals/c2/19/53/c21953f3ad4a17d96eb80d649bc8149b.jpg")!,
        //        URL(string: "https://images.pexels.com/photos/514241/pexels-photo-514241.jpeg?w=1260&h=750&dpr=2&auto=compress&cs=tinysrgb")!
        //
        
        ["https://static.pexels.com/photos/257360/pexels-photo-257360.jpeg",
         "https://i.pinimg.com/originals/c2/19/53/c21953f3ad4a17d96eb80d649bc8149b.jpg",
         "https://images.pexels.com/photos/514241/pexels-photo-514241.jpeg?w=1260&h=750&dpr=2&auto=compress&cs=tinysrgb"],[ "https://www-tc.pbs.org/wnet/nature/files/2017/03/1007.jpg",
         "https://i.pinimg.com/736x/53/62/a9/5362a940ab654152d8411b0d2f56d874--sunrise-pictures-nature-pictures.jpg"]]
        
    
    
    var data : [[String]] = [["http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg",
                              "http://ww1.sinaimg.cn/mw600/c0679ecagw1f6ff6ar7v7j20gt0me3yy.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff6csucjj20gt0aijrh.jpg",
                              "http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg",
                              "http://ww1.sinaimg.cn/mw600/c0679ecagw1f6ff6ar7v7j20gt0me3yy.jpg"],
                            ["http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg",
                              "http://ww1.sinaimg.cn/mw600/c0679ecagw1f6ff6ar7v7j20gt0me3yy.jpg"],
                            ["http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg"],
                            ["http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg",
                              "http://ww1.sinaimg.cn/mw600/c0679ecagw1f6ff6ar7v7j20gt0me3yy.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff6csucjj20gt0aijrh.jpg",
                              "http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg"],
                            ["http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg",
                              "http://ww1.sinaimg.cn/mw600/c0679ecagw1f6ff6ar7v7j20gt0me3yy.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff6csucjj20gt0aijrh.jpg",
                              "http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg"],
                            ["http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg",
                              "http://ww1.sinaimg.cn/mw600/c0679ecagw1f6ff6ar7v7j20gt0me3yy.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff6csucjj20gt0aijrh.jpg",
                              "http://ww4.sinaimg.cn/mw600/7352978fgw1f6gkap8p45j20f00f074t.jpg",
                              "http://ww3.sinaimg.cn/mw600/c0679ecagw1f6ff68fzb1j20gt0gtwhf.jpg",
                              "http://ww4.sinaimg.cn/mw600/c0679ecagw1f6ff69na87j20gt08a3z2.jpg",
                              "http://ww1.sinaimg.cn/mw600/c0679ecagw1f6ff6ar7v7j20gt0me3yy.jpg"]]
    
    
    
    
    
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
        
        let gridWidth = UIScreen.main.bounds.size.width //- 56 - 8
        
        // get height for the image grid
        imageGridHeight.constant = FTImageGridView.getHeightWithWidth(gridWidth, imgCount: 2)
        
        // show images in grid
        imageGridView.showWithImageArray(imageArray) { (buttonsArray, buttonIndex) in
            // preview images with one line of code
            FTImageViewer.showImages(imageArray, atIndex: buttonIndex, fromSenderArray: buttonsArray)
        }
    }
    
    
}



