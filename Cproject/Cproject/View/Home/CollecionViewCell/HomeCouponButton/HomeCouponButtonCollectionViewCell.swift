//
//  HomeCouponButtonCollectionViewCell.swift
//  Cproject
//
//  Created by 엄태양 on 4/1/24.
//

import UIKit
import Combine

final class HomeCouponButtonCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeCouponButtonCollectionViewCell"
    
    private weak var didTapCouponDownload: PassthroughSubject<Void, Never>?
    
    @IBOutlet private weak var couponButton: UIButton! {
        didSet {
            couponButton.setImage(CPImage.btnActivate, for: .normal)
            couponButton.setImage(CPImage.btnComplete, for: .disabled)
        }
    }
    
    func setViewModel(_ viewModel: HomeCouponButtonCollectionViewCellViewModel, _ didTapCouponDownload: PassthroughSubject<Void, Never>?) {
        couponButton.isEnabled = switch viewModel.state {
            case .enable:
                true
            case .disable:
                false
        }
        self.didTapCouponDownload = didTapCouponDownload
    }
    @IBAction private func didTapCouponButton(_ sender: Any) {
        didTapCouponDownload?.send()
    }
}

extension HomeCouponButtonCollectionViewCell {
    static func couponButtonItemLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(37)
        )
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 28, leading: 22, bottom: 0, trailing: 22)
        
        return section
    }
}
