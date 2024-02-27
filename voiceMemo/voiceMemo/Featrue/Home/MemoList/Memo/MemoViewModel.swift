//
//  MemoViewModel.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/14/24.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
