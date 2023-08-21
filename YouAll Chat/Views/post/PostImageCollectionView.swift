//
//  PostImageCollectionView.swift
//  YouAll Chat
//
//  Created by Umer on 18/08/2023.
//

import UIKit


class PostImageCollectionView : NSObject{
    var images :[String] = []
    
    
}
extension PostImageCollectionView: UICollectionViewDataSource, UICollectionViewDelegate{
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
        if images.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionCell
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionCell
            
            let lastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionLastCell", for: indexPath as IndexPath) as! CollectionLastCell
            
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
    
    
    
}
extension PostImageCollectionView : UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         return getImageSize(indexPath,collectionView )
     }


     //everything is hardcoded at the moment change it in future
    func getImageSize(_ indexPath:IndexPath,_ collectionView: UICollectionView)->CGSize{
         let height = collectionView.frame.height
         let width = collectionView.frame.width

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
             collectionView.bounds.size.height = 1.0
             return CGSize(width:0, height: 0)
         }
     }
}
