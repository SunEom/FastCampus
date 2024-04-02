//
//  FavoriteViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

final class FavoriteViewModel {
    enum Action {
        case fetchFavoriteDataFromAPI
        case getFavroiteSuccess(FavoriteResponse)
        case getFavoriteFailed(Error)
        case didTapPurchaseButton
    }
    
    final class State {
        @Published var tableViewModel: [FavoriteItemTableViewCellViewModel]?
    }
    
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    
    func process(_ action: Action) {
        switch action {
            case .fetchFavoriteDataFromAPI:
                fetchFavoriteFromAPI()
            case let .getFavroiteSuccess(favoriteResponse):
                transformFavoriteitemViewModel(favoriteResponse)
            case let .getFavoriteFailed(error):
                print(error.localizedDescription)
            case .didTapPurchaseButton:
                break
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension FavoriteViewModel {
    private func fetchFavoriteFromAPI() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getFavoriteData()
                process(.getFavroiteSuccess(response))
            } catch {
                process(.getFavoriteFailed(error))
            }
        }
        
    }
    
    private func transformFavoriteitemViewModel(_ response: FavoriteResponse) {
        self.state.tableViewModel = response.favorites.map {
            FavoriteItemTableViewCellViewModel(
                imageUrl: $0.imageUrl,
                productName: $0.title,
                productPrice: $0.discountPrice.moneyString
            )
        }
    }
}
