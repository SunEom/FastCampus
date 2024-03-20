//
//  MyProfileViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/20/24.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
class MyProfileViewModel: ObservableObject {
    
    @Published var userInfo: User?
    @Published var isPresentedEditView: Bool = false
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                await updateProfileImage(pickerItem: imageSelection)
            }
        }
    }
    
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
    
    func updateProfileImage(pickerItem: PhotosPickerItem?) async {
        guard let pickerItem else {
            return
        }
        
        do {
            let data = try await container.services.photoPickerService.loadTransferable(from: pickerItem)
            
            // storage upload
            let url = try await container.services.uploadService.uploadImage(source: .profile(userId: userId), data: data)
            
            // db update
            try await container.services.userService.updateProfileURL(userId: userId, urlString: url.absoluteString)
            
            userInfo?.profileURL = url.absoluteString
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
}
