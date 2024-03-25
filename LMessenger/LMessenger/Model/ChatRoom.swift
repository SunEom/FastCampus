//
//  ChatRoom.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

struct ChatRoom: Hashable {
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

extension ChatRoom {
    static let stub1: ChatRoom = .init(chatRoomId: "123", otherUserName: User.stub1.name, otherUserId: User.stub1.id)
    static let stub2: ChatRoom = .init(chatRoomId: "456", otherUserName: User.stub2.name, otherUserId: User.stub2.id)
}
