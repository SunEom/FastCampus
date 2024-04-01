//
//  Numeric+Extensions.swift
//  Cproject
//
//  Created by 엄태양 on 4/1/24.
//

import Foundation

extension Numeric {
    var moneyString: String {
        let formatter: NumberFormatter = .init()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return (formatter.string(for: self) ?? "") + "원"
    }
}
