//
//  DetailPurchaseViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

final class DetailPurchaseViewModel: ObservableObject {
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    @Published var isFavorite: Bool
}
