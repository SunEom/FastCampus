//
//  NavigationRouter.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import Foundation

class NavigationRouter: ObservableObject {
    @Published var destinations: [NavigationDestination] = []
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    func pop() {
        _ = destinations.popLast()
    }
    
    func popToRootView() {
        destinations = []
    }
}
