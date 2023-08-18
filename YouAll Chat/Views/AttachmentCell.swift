//
//  AttachmentCell.swift
//  YouAll Chat
//
//  Created by Umer on 10/08/2023.
//

import UIKit
import FirebaseStorage

class AttachmentCell: UICollectionViewCell{
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var attachmentImage: UIImageView!
    
    var attachmentImageModel :AttachmentImage?
    let serialQueue = DispatchQueue(label: "imageUpload")
    
    var imageUrl : String = "nil"
    
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
    
    func setProgress(value: Float){
        
        progressBar.progress = value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}


