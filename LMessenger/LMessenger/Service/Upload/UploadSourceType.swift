//
//  UploadSourceType.swift
//  LMessenger
//
//  Created by 엄태양 on 3/20/24.
//

import Foundation

enum UploadSourceType {
    case chat(chatRoomId: String)
    case profile(userId: String)
    
    var path: String {
        switch self {
            case let .chat(chatRoomId): //Chats/chatRoomId
                return "\(DBKey.Chats)/\(chatRoomId)"
            case let .profile(userId): //Users/UserId
                return "\(DBKey.Users)/\(userId)"
        }
    }
}
