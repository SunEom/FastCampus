//
//  AppearanceController.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import Foundation
import Combine

protocol AppearanceControllable {
    var appearance: AppearanceType { get set  }
    
    func changeAppearance(_ willBeAppearance: AppearanceType?)
}

class AppearanceController: AppearanceControllable, ObservableObjectSettable {
    var objectWillChange: ObservableObjectPublisher?
    
    var appearance: AppearanceType = .automatic {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func changeAppearance(_ willBeAppearance: AppearanceType?) {
        appearance = willBeAppearance ?? .automatic
    }
    
    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher) {
        self.objectWillChange = objectWillChange
    }
}
