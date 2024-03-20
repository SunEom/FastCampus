//
//  MyProfileViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/20/24.
//

import Foundation

@MainActor
class MyProfileViewModel: ObservableObject {
    
    @Published var userInfo: User?
    @Published var isPresentedEditView: Bool = false
    
    private let userId: String
    
    private var container: DIContainer
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
    
    func updateDescription(_ description: String) async {
        do {
            try await self.container.services.userService.updateDescription(userId: userId, description: description)
            userInfo?.description = description
        } catch {
            
        }
    }
}
