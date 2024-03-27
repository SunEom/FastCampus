//
//  SearchDataController.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import Foundation
import CoreData

protocol DataControllable {
    var persistantContainer: NSPersistentContainer { get set }
}

class SearchDataController: DataControllable {
    
    var persistantContainer = NSPersistentContainer(name: "Search")
    
    init() {
        persistantContainer.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed: \(error.localizedDescription)")
            }
        }
    }
}
