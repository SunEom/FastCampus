//
//  Video.swift
//  KTV
//
//  Created by 엄태양 on 3/6/24.
//

import Foundation

struct Video: Decodable {
    let videoURL: URL
    let channelImageUrl: URL
    let uploadTimestamp: TimeInterval
    let channel: String
    let channelId: Int
    let title: String
    let videoId: Int
    let playCount: Int
    let recommends: [VideoListItem]
    let favoriteCount: Int
}
