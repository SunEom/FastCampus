//
//  DetailRateViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

final class DetailRateViewModel: ObservableObject {
    init(rate: Int) {
        self.rate = rate
    }
    
    @Published var rate: Int
}
