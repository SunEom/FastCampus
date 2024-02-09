//
//  OnboardingContent.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/8/24.
//

import Foundation

struct OnboardingContent: Hashable {
    var imageFileName: String
    var title: String
    var subtitle: String
    
    init(
        imageFileName: String,
        title: String,
        subtitle: String
    ) {
        self.imageFileName = imageFileName
        self.title = title
        self.subtitle = subtitle
    }
}
