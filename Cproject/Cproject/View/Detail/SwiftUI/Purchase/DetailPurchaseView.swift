//
//  DetailPurchaseView.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import SwiftUI

struct DetailPurchaseView: View {
    @ObservedObject var viewModel: DetailPurchaseViewModel
    var onFavoriteTap: () -> Void
    var onPurchaseTap: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            Button {
                onFavoriteTap()
            } label: {
                Image(viewModel.isFavorite ? .favoriteOn : .favoriteOff)
            }
            
            
            Button {
                onPurchaseTap()
            } label: {
                Text("구매하기")
                    .font(Font(CPFont.m16))
                    .foregroundStyle(Color(CPColor.wh))
                    
            }
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(Color(CPColor.keyColorBlue))
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

#Preview {
    DetailPurchaseView(viewModel: DetailPurchaseViewModel(isFavorite: true), onFavoriteTap: {}, onPurchaseTap: {} )
}
