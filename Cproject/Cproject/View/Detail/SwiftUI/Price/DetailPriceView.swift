//
//  DetailPriceView.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import SwiftUI

struct DetailPriceView: View {
    @ObservedObject var viewModel: DetailPriceViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 21) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing:0) {
                    Text(viewModel.discountRate)
                        .font(Font(CPFont.b16))
                        .foregroundStyle(Color(CPColor.gray5))
                    
                    Text(viewModel.originPrice)
                        .strikethrough()
                        .font(Font(CPFont.b14))
                        .foregroundStyle(Color(CPColor.icon))
                }
                Text(viewModel.currentPrice)
                    .font(Font(CPFont.b20))
                    .foregroundStyle(Color(CPColor.keyColorRed))
            }
            Text(viewModel.shippingtype)
                .font(Font(CPFont.r12))
                .foregroundStyle(Color(CPColor.icon))
        }
        
    }
}

#Preview {
    DetailPriceView(viewModel: DetailPriceViewModel(
        discountRate: "53%",
        originPrice: "300,000원",
        currentPrice: "139,000원",
        shippingtype: "무료배송"
    ))
}
