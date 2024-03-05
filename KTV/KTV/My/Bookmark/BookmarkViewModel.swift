//
//  BookmarkViewModel.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import Foundation

@MainActor class BookmarkViewModel {
    private var bookmark: Bookmark?
    var channels: [Bookmark.Item]?
    var dataChanged:( () -> Void)?
    
    func requestData() {
        Task {
            do {
                self.bookmark = try await DataLoader.load(url: URLDefines.bookmark, for: Bookmark.self)
                self.channels = self.bookmark?.channels
                self.dataChanged?()
            } catch {
                print("json parsing failed: \(error.localizedDescription)")
            }
        }
    }
}
