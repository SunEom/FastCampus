//
//  ChatRoomObject.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

struct ChatRoomObject: Codable {
    var chatRoomId: String
    var lastMesage: String?
    var otherUserName: String
    var otherUserId: String
}

extension ChatRoomObject {
    func toModel() -> ChatRoom {
        .init(
            chatRoomId: chatRoomId,
            lastMesage: lastMesage,
            otherUserName: otherUserName,
            otherUserId: otherUserId
        )
    }
}

extension ChatRoomObject {
    static var stub1: ChatRoomObject {
        .init(
            chatRoomId: "chatRoom1_id",
            otherUserName: "user2",
            otherUserId: "user2_id"
        )
    }
}
