//
//  InfiniteDirectionsDataSource.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/11/23.
//

import Foundation
import UIKit

class InfiniteDirectionsDataSource: NSObject {
    
    var directions: [String] = []
    private let maxCellCount = 500
}

extension InfiniteDirectionsDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return directions.isEmpty == false ? maxCellCount : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseIdentifier, for: indexPath) as! CollectionCell
        let direction = directions[indexPath.row % directions.count]
        cell.configure(text: direction, isSelected: false)
        return cell
    }
}

