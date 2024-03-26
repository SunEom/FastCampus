//
//  PushNotificationService.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import Foundation
import FirebaseMessaging

protocol PushNotificationServiceType {
    func requestAuthorication(completion: @escaping (Bool) -> Void)
}

class PushNotificationService: NSObject, PushNotificationServiceType {
    
    
    override init() {
        super.init()
        
        Messaging.messaging().delegate = self
    }
    
    func requestAuthorication(completion: @escaping (Bool) -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if let error {
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
}

extension PushNotificationService: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("messaging:didReceiveRegistrationToken: \(fcmToken)")
    }
}

class StubPushNotificationService: PushNotificationServiceType {
    func requestAuthorication(completion: @escaping (Bool) -> Void) {
        
    }
}
