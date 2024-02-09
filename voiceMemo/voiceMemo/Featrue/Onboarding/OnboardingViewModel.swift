//
//  OnboardingViewModel.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/8/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var onboarindgContents: [OnboardingContent]
    
    init(
        onboarindgContents: [OnboardingContent] = [
            .init(
                imageFileName: "onboarding_1",
                title: "오늘의 할일",
                subtitle: "To do List로 언제 어디서든 해야할 일을 한눈에"
            ),
            .init(
                imageFileName: "onboarding_2",
                title: "똑똑한 나만의 기록장",
                subtitle: "메모장으로 생각나는 기록은 언제든지"
            ),
            .init(
                imageFileName: "onboarding_3",
                title: "하나라도 놓치지 않도록",
                subtitle: "음성메모 기능으로 놓치고 싶지않은 기록까지"
            ),
            .init(
                imageFileName: "onboarding_4",
                title: "정확한 시간의 경과",
                subtitle: "타이머 기능으로 원하는 시간을 확인"
            ),
        ]
    ) {
        self.onboarindgContents = onboarindgContents
    }
}
