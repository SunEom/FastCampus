//
//  FavoriteViewModel.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import Foundation

@MainActor class FavoriteViewModel {
    private var favorite: Favorite?
    var list: [VideoListItem]?
    var dataChanged: (() -> Void)?
    
    func requestData() {
        Task {
            do {
                self.favorite = try await DataLoader.load(
                    url: URLDefines.favorite,
                    for: Favorite.self
                )
                self.list = favorite?.list
                self.dataChanged?()
            } catch {
                print("json parsing Error: \(error.localizedDescription)")
            }
        }
    }
}
