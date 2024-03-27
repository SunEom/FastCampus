//
//  AppearanceType.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import SwiftUI

enum AppearanceType: Int, CaseIterable, SettingItemable {
    case automatic
    case light
    case dark
    
    var label: String {
        switch self {
            case .automatic:
                "시스템모드"
            case .light:
                "라이트모드"
            case .dark:
                "다크모드"
        }
    }
    
    var colorSchme: ColorScheme? {
        switch self {
            case .automatic:
                return nil
            case .light:
                return .light
            case .dark:
                return .dark
        }
    }
}
