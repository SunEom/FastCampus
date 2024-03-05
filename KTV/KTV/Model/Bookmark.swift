//
//  Bookmark.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import Foundation

struct Bookmark: Decodable {
    let channels: [Item]
}

extension Bookmark {
    struct Item: Decodable {
        let channel: String
        let channelId: Int
        let thumbnail: URL
    }
}
