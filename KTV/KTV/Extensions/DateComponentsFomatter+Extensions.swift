//
//  DateComponentsFomatter+Extensions.swift
//  KTV
//
//  Created by 엄태양 on 3/8/24.
//

import Foundation

extension DateComponentsFormatter {
    static let playTimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
}
