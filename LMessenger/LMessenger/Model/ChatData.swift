//
//  ChatData.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
