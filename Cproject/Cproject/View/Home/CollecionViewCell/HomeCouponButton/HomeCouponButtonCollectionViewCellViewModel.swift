//
//  HomeCouponButtonCollectionViewCellViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/1/24.
//

import Foundation

struct HomeCouponButtonCollectionViewCellViewModel: Hashable {
    enum CouponState {
        case enable
        case disable
    }
    
    var state: CouponState
}
