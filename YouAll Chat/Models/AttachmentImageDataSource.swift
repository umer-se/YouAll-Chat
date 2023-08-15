//
//  AttachmentImageDataSource.swift
//  YouAll Chat
//
//  Created by Umer on 12/08/2023.
//

protocol AttachmentDataSourceDelegate {
    func didSelectItems()
    func didDeselectItems()
}



import UIKit


class AttachmentImageDataSource : NSObject{
    
    var delegate : AttachmentDataSourceDelegate?
    var imagesFromDataSource : [AttachmentImage] = []
    
    var images: [UIImage] = []
    var deleteButtonValue: Bool = false
}


extension AttachmentImageDataSource : UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.attachmentImageIdentifier, for: indexPath) as! AttachmentCell
        
        cell.setupImageCell(pickedImage: images[indexPath.item])
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView.indexPathsForSelectedItems?.count == 0{
            
            delegate?.didDeselectItems()
            
        }
        
    }
    
    func deleteItems(at indexPath: [Int]){
        
     let imagesToRemove = images.remove(elementsAtIndices: indexPath)
        images.removeAll { savedImage in
            imagesToRemove.contains { selectedImage in
               savedImage == selectedImage
            }
        }
    }
}


extension Array {
    mutating func remove(elementsAtIndices indicesToRemove: [Int]) -> [Element] {
        guard !indicesToRemove.isEmpty else {
            return []
        }
        
        // Copy the removed elements in the specified order.
        let removedElements = indicesToRemove.map { self[$0] }
        
        // Sort the indices to remove.
        let indicesToRemove = indicesToRemove.sorted()
        
        // Shift the elements we want to keep to the left.
        var destIndex = indicesToRemove.first!
        var srcIndex = destIndex + 1
        func shiftLeft(untilIndex index: Int) {
            while srcIndex < index {
                self[destIndex] = self[srcIndex]
                destIndex += 1
                srcIndex += 1
            }
            srcIndex += 1
        }
        for removeIndex in indicesToRemove[1...] {
            shiftLeft(untilIndex: removeIndex)
        }
        shiftLeft(untilIndex: self.endIndex)
        
        // Remove the extra elements from the end of the array.
        self.removeLast(indicesToRemove.count)
        
        return removedElements
    }
}

