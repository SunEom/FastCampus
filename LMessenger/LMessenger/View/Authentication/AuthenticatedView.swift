//
//  AuthenticatedView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import SwiftUI
import CoreData

struct AuthenticatedView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var authViewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
                case .unauthenticated:
                    LoginIntroView()
                        .environmentObject(authViewModel)
                case .authenticated:
                    MainTabView()
                        .environment(\.managedObjectContext, container.searchDataController.persistantContainer.viewContext )
                        .environmentObject(authViewModel)
                        .onAppear {
                            authViewModel.send(action: .requestPushNotification)
                        }
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
        .preferredColorScheme(container.appearanceController.appearance.colorSchme)
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
}

