//
//  LMessengerApp.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import SwiftUI

@main
struct LMessengerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(
                authViewModel: .init(container: container),
                navigationRouter: .init()
            )
                .environmentObject(container)
        }
    }
}
