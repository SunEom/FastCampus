//
//  HomeProductCollectionViewCellViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 3/29/24.
//

import Foundation

struct HomeProductCollectionViewCellViewModel: Hashable {
    let imageUrlString: String
    let title: String
    let reasonDiscountString: String
    let originalPrice: String
    let discountPrice: String
}
