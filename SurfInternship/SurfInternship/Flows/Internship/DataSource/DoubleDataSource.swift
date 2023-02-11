//
//  DoubleDataSource.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/11/23.
//
import Foundation
import UIKit

class DoubleDataSource: NSObject {
    
    var directions: [String] = []
    private var selectedIndexPath: IndexPath?
}

extension DoubleDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return directions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseIdentifier, for: indexPath) as! CollectionCell
        let direction = directions[indexPath.row]
        cell.configure(text: direction, isSelected: selectedIndexPath == indexPath )
        return cell
    }
}

extension DoubleDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let lastSelectedPath = selectedIndexPath
        
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            directions.swapAt(indexPath.row, 0)
            selectedIndexPath = IndexPath(row: 0, section: 0)
        }
        collectionView.reloadItems(at: [indexPath,lastSelectedPath ?? .init(row: 0, section: 0)])
    }
}
