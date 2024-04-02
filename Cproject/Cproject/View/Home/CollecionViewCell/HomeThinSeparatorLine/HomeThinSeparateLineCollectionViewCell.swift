//
//  HomeThinSeparateLineCollectionViewCell.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import UIKit

class HomeThinSeparateLineCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeThinSeparateLineCollectionViewCell"
    
    func setViewModel(_ viewModel: HomeThinSeparateLineCollectionViewCellViewModel) {
        
    }
}

extension HomeThinSeparateLineCollectionViewCell {
    static func setSeparateLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(1)
        )
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
