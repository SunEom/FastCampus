//
//  NavigationDestination.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

enum NavigationDestination: Hashable {
    case chat(chatRoomId: String, myUserId: String, otherUserId: String)
    case search(userId: String)
}
