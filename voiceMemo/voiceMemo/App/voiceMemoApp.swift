//
//  voiceMemoApp.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/8/24.
//

import SwiftUI

@main
struct voiceMemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
