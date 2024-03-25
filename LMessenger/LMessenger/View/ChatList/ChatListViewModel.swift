//
//  ChatListViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation
import Combine

class ChatListViewModel: ObservableObject {
    
    enum Action {
        case load
    }
    
    @Published var chatRooms: [ChatRoom] = []
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    private(set) var userId: String
    
    init(container: DIContainer, userId: String){
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
            case .load:
                container.services.chatRoomService.loadChatRooms(myUserId: userId)
                    .sink { completion in
                        
                    } receiveValue: { [weak self] chatrooms in
                        self?.chatRooms = chatrooms
                    }.store(in: &subscriptions)
        }
    }
}
