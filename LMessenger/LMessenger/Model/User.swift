//
//  User.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import Foundation

struct User {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}


extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "김하늘")
    }
    
    static var stub2: User {
        .init(id: "user2_id", name: "김코랄")
    }
}
