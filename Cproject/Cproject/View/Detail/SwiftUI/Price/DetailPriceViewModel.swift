//
//  DetailPriceViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

final class DetailPriceViewModel: ObservableObject{
    init(discountRate: String, originPrice: String, currentPrice: String, shippingtype: String) {
        self.discountRate = discountRate
        self.originPrice = originPrice
        self.currentPrice = currentPrice
        self.shippingtype = shippingtype
    }
    
    @Published var discountRate: String
    @Published var originPrice: String
    @Published var currentPrice: String
    @Published var shippingtype: String
}
