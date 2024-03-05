//
//  VideoListItem.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import Foundation

struct VideoListItem: Decodable {
    let imageUrl: URL
    let title: String
    let playtime: Double
    let channel: String
    let videoId: Int
}
