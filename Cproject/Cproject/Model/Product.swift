//
//  Product.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
    let discount: String
    let originalPrice: Int
    let discountPrice: Int
}
