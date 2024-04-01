//
//  HomeProductCollectionViewCell.swift
//  Cproject
//
//  Created by 엄태양 on 3/29/24.
//

import UIKit


final class HomeProductCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeProductCollectionViewCell"
    @IBOutlet private weak var productItemImageView: UIImageView! {
        didSet {
            productItemImageView.layer.cornerRadius = 5
        }
    }
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productReasonDiscountLabel: UILabel!
    @IBOutlet private weak var originalPriceLabel: UILabel!
    @IBOutlet private weak var discountPriceLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeProductCollectionViewCellViewModel) {
        //TODO: set image
        productItemImageView.kf.setImage(with: URL(string: viewModel.imageUrlString))
        productTitleLabel.text = viewModel.title
        productReasonDiscountLabel.text = viewModel.reasonDiscountString
        originalPriceLabel.attributedText = NSMutableAttributedString(
            string: viewModel.originalPrice,
            attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue]
        )
        discountPriceLabel.text = viewModel.discountPrice
    }
    
}

extension HomeProductCollectionViewCell {
    static func horizontalProductItemLayout() -> NSCollectionLayoutSection{
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(119),
            heightDimension: .estimated(224)
        )
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 14
        section.contentInsets = .init(top: 25, leading: 31, bottom: 31, trailing: 40)
        
        return section
    }
    
    static func verticalProductItemLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1/2),
            heightDimension: .estimated(277)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(277)
        )
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(5)
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 14
        section.contentInsets = .init(top: 20, leading: 19 - 2.5, bottom: 0, trailing: 19 - 2.5)
        
        return section
    }
}
