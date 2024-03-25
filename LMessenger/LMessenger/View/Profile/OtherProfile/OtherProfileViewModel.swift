//
//  OtherProfileViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

@MainActor
class OtherProfileViewModel: ObservableObject {
    @Published var userInfo: User?
    
    private let userId: String
    private let container: DIContainer
    
    init(userId: String, container: DIContainer) {
        self.userId = userId
        self.container = container
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
}
