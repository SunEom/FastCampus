//
//  DIContainer.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    var searchDataController: DataControllable
    var navigationRouter: NavigationRoutable & ObservableObjectSettable
    var appearanceController: AppearanceController & ObservableObjectSettable
    
    init(
        services: ServiceType,
        searchDataController: DataControllable = SearchDataController(),
        navigationRouter: NavigationRoutable & ObservableObjectSettable = NavigationRouter(),
        appearanceController: AppearanceController & ObservableObjectSettable = AppearanceController()
    ) {
        self.services = services
        self.searchDataController = searchDataController
        self.navigationRouter = navigationRouter
        self.appearanceController = appearanceController
        
        self.navigationRouter.setObjectWillChange(self.objectWillChange)
        self.appearanceController.setObjectWillChange(self.objectWillChange)
    }
}
