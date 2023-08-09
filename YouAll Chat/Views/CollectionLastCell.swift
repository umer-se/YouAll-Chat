//
//  CollectionLastCell.swift
//  YouAll Chat
//
//  Created by Umer on 08/08/2023.
//

import UIKit


class CollectionLastCell : UICollectionViewCell{
    
    let identifier = "collectionLastCell"
    
    @IBOutlet weak var photoCounter: UILabel!
    
    @IBOutlet weak var lastImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
