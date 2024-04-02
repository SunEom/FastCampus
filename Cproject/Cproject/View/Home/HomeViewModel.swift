//
//  HomeViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/1/24.
//

import Foundation
import Combine

//MVI 패턴

final class HomeViewModel {
    
    enum Action {
        case loadData
        case loadCoupon
        case loadCategory
        case getDataSuccess(HomeResponse)
        case getDataFail(Error)
        case getCouponSucces(Bool)
        case getCategorySuccess([Category])
        case didTapCouponButton
    }
    
    final class State {
        struct CollectionViewModels {
            var bannerViewModels: [ HomeBannerCollectionViewCellViewModel]?
            var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var thinSeparateLineViewModels: [HomeThinSeparateLineCollectionViewCellViewModel] = [.init()]
            var categoryViewModels: [HomeCategoryCellViewModel] = []
            var separateLine1ViewModel: [HomeSeparateLineCollectionViewCellViewModel] = [HomeSeparateLineCollectionViewCellViewModel()]
            var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var couponViewModels: [HomeCouponButtonCollectionViewCellViewModel]?
            var separateLine2ViewModel: [HomeSeparateLineCollectionViewCellViewModel] = [HomeSeparateLineCollectionViewCellViewModel()]
            var themeViewModels: (headerViewModel: HomeThemeHeaderViewModel, items: [HomeThemeCollectionViewCellViewModel]?) = (headerViewModel: HomeThemeHeaderViewModel(headerText: "테마관"), items: nil)
        }
        
        @Published var collectionViewModels: CollectionViewModels = CollectionViewModels()
    }
    
    
    private var loadDataTask: Task<Void, Never>?
    private(set) var state: State = State()
    private let couponDownloadedKey: String = "CouponDownloaded"
    
    func process(action: Action) {
        switch action {
            case .loadData:
                self.loadData()
                
            case .loadCoupon:
                self.loadCoupon()
                
            case .loadCategory:
                self.loadCategory()
                
            case let .getDataSuccess(response):
                transformResponse(response)
                
            case let .getDataFail(error):
                print("network error: \(error.localizedDescription)")
                
            case let .getCouponSucces(isDownloaded):
                Task { await transformCoupon(isDownloaded) }
                
            case let .getCategorySuccess(categories):
                Task { await transformCategory(categories) }
                
            case .didTapCouponButton:
                downloadCoupon()
                
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension HomeViewModel {
    
    private func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getHomeData()
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFail(error))
            }
        }
    }
    
    private func loadCoupon() {
        let couponState: Bool = UserDefaults.standard.bool(forKey: couponDownloadedKey)
        process(action: .getCouponSucces(couponState))
    }
    
    private func loadCategory() {
        process(action: .getCategorySuccess(Category.allCases))
    }
    
    private func transformResponse(_ response: HomeResponse) {
        Task { await transformBanner(response) }
        Task { await transformHorizontalProduct(response) }
        Task { await transformVerticalProduct(response) }
        Task { await transformTheme(response) }
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        self.state.collectionViewModels.bannerViewModels = response.banners.map { HomeBannerCollectionViewCellViewModel(bannerImageUrl: $0.imageUrl) }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        self.state.collectionViewModels.horizontalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.horizontalProducts)
    }
    
    @MainActor
    private func transformCategory(_ categories: [Category]) async {
        self.state.collectionViewModels.categoryViewModels = categories.map { HomeCategoryCellViewModel(category: $0) }
    }
    
    @MainActor
    private func transformVerticalProduct(_ response: HomeResponse) async {
        self.state.collectionViewModels.verticalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.verticalProducts)
    }
    
    @MainActor
    private func transformCoupon(_ isDownloaded: Bool) async {
        self.state.collectionViewModels.couponViewModels = [.init(state: isDownloaded ? .disable : .enable)]
    }
    
    @MainActor
    private func transformTheme(_ response: HomeResponse) async {
        let items = response.themes.map {
            HomeThemeCollectionViewCellViewModel(themeImageUrl: $0.imageUrl)
        }
        
        self.state.collectionViewModels.themeViewModels = (headerViewModel: HomeThemeHeaderViewModel(headerText: "테마관"), items: items)
    }
    
    private func productToHomeProductCollectionViewCellViewModel(_ products: [Product]) -> [HomeProductCollectionViewCellViewModel] {
        return products.map {
            HomeProductCollectionViewCellViewModel(
                imageUrlString: $0.imageUrl,
                title: $0.title,
                reasonDiscountString: $0.discount,
                originalPrice: $0.originalPrice.moneyString,
                discountPrice: $0.discountPrice.moneyString
            )
        }
    }
    
    private func downloadCoupon() {
        UserDefaults.standard.setValue(true, forKey: couponDownloadedKey)
        process(action: .loadCoupon)
    }
}
