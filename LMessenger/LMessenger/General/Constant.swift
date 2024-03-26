//
//  Constant.swift
//  LMessenger
//
//  Created by 엄태양 on 3/19/24.
//

import Foundation

typealias DBKey = Constant.DBKey
typealias AppStorageType = Constant.AppStorage

enum Constant {
    
}

extension Constant {
    struct DBKey {
        static let Users = "Users"
        static let ChatRooms = "ChatRooms"
        static let Chats = "Chats"
    }
}

extension Constant {
    struct AppStorage {
        static let Appearance = "AppStorage_Appearance"
    }
}
