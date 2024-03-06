//
//  MoreViewModel.swift
//  KTV
//
//  Created by 엄태양 on 3/6/24.
//

import Foundation

@MainActor struct MoreViewModel {
    let items: [MoreItem] = [
        .init(title: "화질 변경", rightText: "자동 720p"),
        .init(title: "자동 재생", rightText: "On"),
        .init(title: "공유하기", rightText: nil),
        .init(title: "신고하기", rightText: nil),
    ]
}

struct MoreItem {
    let title: String
    let rightText: String?
}
