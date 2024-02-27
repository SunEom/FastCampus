//
//  Memo.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/14/24.
//

import Foundation

struct Memo: Hashable {
    var title: String
    var content: String
    var date: Date
    var id = UUID()
    
    var convertedDate: String {
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
    
}
