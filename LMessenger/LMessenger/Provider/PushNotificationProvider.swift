//
//  PushNotificationProvider.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import Foundation
import Combine

protocol PushNotificationProviderType {
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never>
}

class PushNotificationProvider: PushNotificationProviderType {
    
    private let serverURL: URL = URL(string: "https://fcm.googleapis.com/fcm/send")!
    private let serverKey = "AAAAXeK7sAw:APA91bHakMh1BtTlEs6B28YmKUSD7XLiUho8GwjaZwN0y0EjU0DsehhHD8RcCBbUQUMl2qu7HfZWU2BWwwOaXvOId-ao4aAJnYDfu-PeWvoiFFGqMKA1rQS3ze7JtulRgEYHqR-t9EQz"
    
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never> {
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(object)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
        
    }
}
