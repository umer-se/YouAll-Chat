//
//  CollectionViewProtocol.swift
//  YouAll Chat
//
//  Created by Umer on 18/08/2023.
//


import UIKit

protocol CollectionViewDequeueProtocol {
    func dequeue(for collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell
}
