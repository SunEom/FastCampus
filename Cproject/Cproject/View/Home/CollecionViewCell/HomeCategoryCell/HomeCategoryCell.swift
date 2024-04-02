//
//  HomeCategoryCell.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import UIKit

final class HomeCategoryCell: UICollectionViewCell {
    static let identifier: String = "HomeCategoryCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeCategoryCellViewModel) {
        imageView.image = viewModel.category.getBigImage()
        titleLabel.text = viewModel.category.getTitle()
    }
    
}

extension HomeCategoryCell {
    static func setCategoryLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(80),
            heightDimension: .absolute(80)
        )
        
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute((80*4)+(4*3)),
            heightDimension: .absolute(80)
        )
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(4)
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 13, leading: 30, bottom: 13, trailing: 30)
        
        return section
    }
}
