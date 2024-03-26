//
//  HomeModalDestination.swift
//  LMessenger
//
//  Created by 엄태양 on 3/19/24.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    case setting
    
    var id: Int {
        hashValue
    }
}
