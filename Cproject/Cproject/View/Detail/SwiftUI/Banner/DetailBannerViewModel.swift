//
//  DetailBannerViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

final class DetailBannerViewModel: ObservableObject {
    init(imageURls:[String]) {
        self.imageUrls = imageURls
    }
    
    @Published var imageUrls: [String]
}
