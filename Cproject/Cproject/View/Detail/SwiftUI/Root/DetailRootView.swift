//
//  DetailRootView.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import SwiftUI
import Kingfisher

struct DetailRootView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack(spacing:0) {
                    bannerView
                    rateView
                    titleView
                    optionView
                    priceView
                    mainImageView
                }
            }
            moreView
            purchaseView
        }
        .onAppear {
            viewModel.process(.loadData)
        }
    }
    
    @ViewBuilder
    var bannerView: some View {
        if let bannersViewModel = viewModel.state.banners {
            DetailBannerView(viewModel: bannersViewModel)
                .padding(.bottom, 15)
        }
    }
    
    @ViewBuilder
    var rateView: some View {
        if let rateViewModel = viewModel.state.rate {
            HStack {
                Spacer()
                DetailRateView(viewModel: rateViewModel)
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        if let title = viewModel.state.title {
            HStack(spacing: 0) {
                Text(title)
                    .font(Font(CPFont.m17))
                    .foregroundStyle(Color(CPColor.bk))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
        
    @ViewBuilder
    var optionView: some View {
        if let optionViewModel = viewModel.state.option {
            Group {
                DetailOptionView(viewModel: optionViewModel)
                    .padding(.bottom, 32)
                
                HStack(spacing:0) {
                    Spacer()
                    Button {
                        viewModel.process(.didTapChangeOption)
                    } label: {
                        Text("옵션 선택하기")
                            .font(Font(CPFont.m12))
                            .foregroundStyle(Color(CPColor.keyColorBlue))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    var priceView: some View {
        if let priceViewModel = viewModel.state.price {
            HStack(spacing: 0) {
                DetailPriceView(viewModel: priceViewModel)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
            
        }
    }
    
    @ViewBuilder
    var mainImageView: some View {
        if let mainImageUrls = viewModel.state.mainImageUrls {
            LazyVStack(spacing: 0) {
                ForEach(mainImageUrls, id: \.self) { imageUrl in
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .padding(.bottom, 32)
            .frame(maxHeight: viewModel.state.more == nil ? .infinity : 200, alignment: .top)
            .clipped()
        }
    }
    
    @ViewBuilder
    var moreView: some View {
        if let moreViewModel = viewModel.state.more {
            DetailMoreView(viewModel: moreViewModel) {
                viewModel.process(.didTapMoreButton)
            }
        }
        
    }
    
    @ViewBuilder
    var purchaseView: some View {
        if let purchaseViewModel = viewModel.state.purchase {
            DetailPurchaseView(viewModel: purchaseViewModel) {
                viewModel.process(.didTapFavorite)
            } onPurchaseTap: {
                viewModel.process(.didTapPurchase)
            }
                .padding(.horizontal, 25)
                .padding(.top, 10)
        }
    }
    
}

#Preview {
    DetailRootView(viewModel: .init())
}
