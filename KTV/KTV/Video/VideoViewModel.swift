//
//  VideoViewModel.swift
//  KTV
//
//  Created by 엄태양 on 3/6/24.
//

import Foundation

@MainActor class VideoViewModel {
    
    private(set) var video: Video?
    var dataChangeHandler: ((Video) -> Void)?
    
    func requestData() {
        Task {
            do {
                self.video = try await DataLoader.load(
                    url: URLDefines.video,
                    for: Video.self
                )
                self.dataChangeHandler?(video!)
                
            } catch {
                print("video load did failed \(error.localizedDescription)")
            }
        }
    }
    
}
