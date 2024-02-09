//
//  Path.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/9/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
