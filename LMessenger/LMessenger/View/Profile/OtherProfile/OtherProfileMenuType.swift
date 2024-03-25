//
//  OtherProfileMenuType.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

enum OtherProfileMenuType: Hashable, CaseIterable {
    case chat
    case voiceTalk
    case videoTalk
    
    var description: String {
        switch self {
        case .chat:
            return "대화"
        case .voiceTalk:
            return "음성통화"
        case .videoTalk:
            return "영상통화"
        }
    }
    
    var imageName: String {
        switch self {
        case .chat:
            return "sms"
        case .voiceTalk:
            return "phone_profile"
        case .videoTalk:
            return "videocam"
        }
    }
}
