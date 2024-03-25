//
//  ChatRoom.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

struct ChatRoom: Codable {
    var chatRoomId: String
    var lastMesage: String?
    var otherUserName: String
    var otherUserId: String
}

extension ChatRoom {
    func toObject() -> ChatRoomObject {
        .init(
            chatRoomId: chatRoomId,
            lastMesage: lastMesage,
            otherUserName: otherUserName,
            otherUserId: otherUserId
        )
    }
}
