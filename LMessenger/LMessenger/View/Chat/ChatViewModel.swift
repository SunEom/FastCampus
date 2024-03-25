//
//  ChatViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import SwiftUI
import PhotosUI
import Combine

class ChatViewModel: ObservableObject {
    
    enum Action {
        case load
        case addChat(String)
        case uploadingIamge(PhotosPickerItem?)
    }
    
    @Published var chatDataList: [ChatData] = []
    @Published var myUser: User?
    @Published var otherUser: User?
    @Published var message: String = ""
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            send(action: .uploadingIamge(imageSelection))
        }
    }
    
    private let chatRoomId: String
    private let myUserId: String
    private let otherUserId: String
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(chatRoomId: String, myUserId: String, otherUserId: String, container: DIContainer) {
        self.chatRoomId = chatRoomId
        self.myUserId = myUserId
        self.otherUserId = otherUserId
        self.container = container
        
        bind()
    }
    
    func bind() {
        container.services.chatService.observeChat(chatRoomId: chatRoomId)
            .sink { [weak self] chat in
                guard let chat else { return }
                self?.updateChatDataList(chat)
            }.store(in: &subscriptions)
    }
    
    func updateChatDataList(_ chat: Chat) {
        let key = chat.date.toChatDataKey
        
        if let index = chatDataList.firstIndex(where: { $0.dateStr == key }) {
            chatDataList[index].chats.append(chat)
        } else {
            let newChatData: ChatData = . init(dateStr: key, chats: [chat])
            chatDataList.append(newChatData)
        }
    }
    
    func getDirection(id: String) -> ChatItemDirection {
        myUserId == id ? .right : .left
    }
    
    func send(action: Action) {
        switch action {
            case .load:
                Publishers.Zip(
                    container.services.userService.getUser(userId: myUserId),
                    container.services.userService.getUser(userId: otherUserId)
                )
                .sink { completion in
                    
                } receiveValue: { [weak self] myUser, otherUser in
                    self?.myUser = myUser
                    self?.otherUser = otherUser
                }.store(in: &subscriptions)
                
            case let .addChat(message):
                let chat = Chat(chatId: UUID().uuidString, userId: myUserId, message: message, date: .now)
                
                container.services.chatService.addChat(
                    chat,
                    to: chatRoomId
                )
                .flatMap { chat in 
                    self.container.services.chatRoomService.updateChatRoomLastMessage(
                        chatRoomId: self.chatRoomId,
                        myUserId: self.myUserId,
                        myUserName: self.myUser?.name ?? "",
                        otherUserId: self.otherUserId,
                        lastMessage: chat.lastMesssage
                    )
                }
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.message = ""
                }.store(in: &subscriptions)

                
            case let .uploadingIamge(pickerItem):
                
                /*
                 1. PhotoPicker Service -> data화
                 2. uploadService -> Storage
                 3. chat -> Add
                 */
                
                guard let pickerItem else { return }
                container.services.photoPickerService.loadTransferable(from: pickerItem)
                    .flatMap { data in
                        return self.container.services.uploadService.uploadImage(source: .chat(chatRoomId: self.chatRoomId), data:data)
                    }.flatMap { url in
                        let chat: Chat = .init(chatId: UUID().uuidString, userId: self.myUserId,photoURL: url.absoluteString, date: .now)
                        return self.container.services.chatService.addChat(chat, to: self.chatRoomId)
                    }
                    .flatMap { chat in
                        self.container.services.chatRoomService.updateChatRoomLastMessage(
                            chatRoomId: self.chatRoomId,
                            myUserId: self.myUserId,
                            myUserName: self.myUser?.name ?? "",
                            otherUserId: self.otherUserId,
                            lastMessage: chat.lastMesssage
                        )
                    }
                    .sink { completion in
                        
                    } receiveValue: { _ in
                        
                    }.store(in: &subscriptions)

        }
    }
}

/*
 
    Chats/
        chatRoomId/
            chatId1/Chat
            chatId2/Chat
            chatId3/Chat
            chatId4/Chat
 
 ---
 Chat: Date > 2023.11.1
 Chat: Date > 2023.11.1
 ---
 Chat: Date > 2023.11.2
 ---
 Chat: Date > 2023.11.3
 ---
 
 */
