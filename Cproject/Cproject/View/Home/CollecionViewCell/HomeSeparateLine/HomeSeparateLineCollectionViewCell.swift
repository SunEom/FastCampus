//
//  HomeSeparateLineCollectionViewCell.swift
//  Cproject
//
//  Created by 엄태양 on 4/1/24.
//

import UIKit

final class HomeSeparateLineCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeSeparateLineCollectionViewCell"
    func setViewModel(_ viewModel: HomeSeparateLineCollectionViewCellViewModel) {
        contentView.backgroundColor = CPColor.gray1
    }
}

extension HomeSeparateLineCollectionViewCell {
    static func separateLineLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(11)
        )
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 13, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}
