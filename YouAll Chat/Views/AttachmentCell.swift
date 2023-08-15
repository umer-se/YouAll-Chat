//
//  AttachmentCell.swift
//  YouAll Chat
//
//  Created by Umer on 10/08/2023.
//

import UIKit

class AttachmentCell: UICollectionViewCell{
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var attachmentImage: UIImageView!
    
    var attachmentImageModel :AttachmentImage?
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                attachmentImage.alpha = 0.5
            }
            else {
                attachmentImage.alpha = 1
            }
        }
    }
    
    
    func setupImageCell (pickedImage : UIImage){
        attachmentImage.image = pickedImage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}
