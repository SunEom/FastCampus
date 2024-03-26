//
//  AuthenticatedView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import SwiftUI
import CoreData

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticatedViewModel
    @StateObject var navigationRouter: NavigationRouter
    @StateObject var searchDataController: SearchDataController
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
                case .unauthenticated:
                    LoginIntroView()
                        .environmentObject(authViewModel)
                case .authenticated:
                    MainTabView()
                        .environment(\.managedObjectContext, searchDataController.persistantContainer.viewContext )
                        .environmentObject(authViewModel)
                        .environmentObject(navigationRouter)
                        .onAppear {
                            authViewModel.send(action: .requestPushNotification)
                        }
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
        
    }
}

#Preview {
    AuthenticatedView(
        authViewModel: .init(container: .init(services: StubService())), 
        navigationRouter: .init(),
        searchDataController: .init()
    )
}

