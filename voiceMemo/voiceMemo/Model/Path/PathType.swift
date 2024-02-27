//
//  PathType.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/9/24.
//

import Foundation

enum PathType: Hashable {
    case homeView
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
