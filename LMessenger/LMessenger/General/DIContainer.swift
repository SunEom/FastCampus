//
//  DIContainer.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
