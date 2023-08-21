//
//  CollectionCell.swift
//  YouAll Chat
//
//  Created by Umer on 08/08/2023.
//

import UIKit
import Kingfisher


class CollectionCell : UICollectionViewCell {
    
    let Identifier = "collectionCell"
    
    @IBOutlet weak var overlay: UILabel!
    @IBOutlet weak var mainView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupcell(imageString : String, count: Int){
        
        mainView.kf.setImage(with: URL(string: imageString))
        mainView.contentMode = .scaleAspectFill
        if count != 0{
            overlay.isHidden = false
            mainView.alpha = 0.5
            overlay.text = String("+\(count)")
            
        }
    }
    override func prepareForReuse() {
        self.mainView.image = nil
        self.mainView.alpha = 1
        self.overlay.isHidden = true
        
    }
    
    
}

