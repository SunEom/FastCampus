//
//  DetailOptionViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

final class DetailOptionViewModel: ObservableObject {
    init(type: String, name: String, imageUrl: String) {
        self.type = type
        self.name = name
        self.imageUrl = imageUrl
    }
    
    @Published var type: String
    @Published var name: String
    @Published var imageUrl: String
    
}
