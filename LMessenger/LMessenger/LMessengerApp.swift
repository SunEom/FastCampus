//
//  LMessengerApp.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import SwiftUI

@main
struct LMessengerApp: App {
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init())
                .environmentObject(container)
        }
    }
}
