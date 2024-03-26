//
//  PushObject.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import Foundation

struct PushObject: Encodable {
    var to: String
    var notification: NotificationObject
    
    struct NotificationObject: Encodable {
        var title: String
        var body: String
    }
}
