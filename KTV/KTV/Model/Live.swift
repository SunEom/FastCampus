//
//  Live.swift
//  KTV
//
//  Created by 엄태양 on 3/8/24.
//

import Foundation

struct Live: Decodable {
    let list: [Item]
}

extension Live {
    struct Item: Decodable {
        let videoId: Int
        let thumbnailUrl: URL
        let title: String
        let channel: String
    }
}
