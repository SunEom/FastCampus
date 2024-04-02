//
//  DetailViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    enum Action {
        case loadData
        case loading(Bool)
        case getDataSuccess(ProductDetailResponse)
        case getDataFailed(Error)
        case didTapChangeOption
        case didTapMoreButton
        case didTapFavorite
        case didTapPurchase
    }
    
    struct State {
        var isLoading: Bool = false
        var banners: DetailBannerViewModel?
        var rate: DetailRateViewModel?
        var title: String?
        var option: DetailOptionViewModel?
        var price: DetailPriceViewModel?
        var mainImageUrls: [String]?
        var more: DetailMoreViewModel?
        var purchase: DetailPurchaseViewModel?
    }
    
    @Published private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    private var isFavorite: Bool = false
    private var needShowMore: Bool = true
    
    func process(_ action: Action) {
        switch action {
            case .loadData:
                loadData()
            case let .getDataSuccess(response):
                Task { await transformProductDeatilResponse(response)}
                
            case let .getDataFailed(error):
                print(error.localizedDescription)
                
            case let .loading(isLoading):
                state.isLoading = isLoading
                
            case .didTapChangeOption:
                break
                
            case .didTapMoreButton:
                needShowMore = false
                state.more = needShowMore ? DetailMoreViewModel() : nil
                
            case .didTapFavorite:
                isFavorite.toggle()
                state.purchase = DetailPurchaseViewModel(isFavorite: isFavorite)
                
            case .didTapPurchase:
                break
        }
    }
    
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension DetailViewModel {
    private func loadData() {
        loadDataTask = Task {
            
            defer {
                process(.loading(false))
            }
            
            do {
                process(.loading(true))
                let response = try await NetworkService.shared.getProductDetailData()
                process(.getDataSuccess(response))
            } catch {
                process(.getDataFailed(error))
            }
        }
    }
    
    @MainActor
    private func transformProductDeatilResponse(_ response: ProductDetailResponse) {
        state.banners = DetailBannerViewModel(imageURls: response.bannerImages)
        
        state.rate = DetailRateViewModel(rate: response.product.rate)
        
        state.title = response.product.name
        
        state.option = DetailOptionViewModel(
            type: response.option.type,
            name: response.option.name,
            imageUrl: response.option.image
        )
        
        state.price = DetailPriceViewModel(
            discountRate: "\(response.product.discountPercent)%",
            originPrice: response.product.originalPrice.moneyString,
            currentPrice: response.product.discountPrice.moneyString,
            shippingtype: "무료배송"
        )
        state.mainImageUrls = response.detailImages
        
        state.more = needShowMore ? DetailMoreViewModel() : nil
        state.purchase = DetailPurchaseViewModel(isFavorite: isFavorite)
    }
}
