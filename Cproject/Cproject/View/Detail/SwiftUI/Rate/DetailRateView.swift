//
//  DetailRateView.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import SwiftUI

struct DetailRateView: View {
    @ObservedObject var viewModel: DetailRateViewModel
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<viewModel.rate, id: \.self) { _ in
                starImage
                    .foregroundColor(Color(uiColor: CPColor.yellow))
            }
            
            ForEach(viewModel.rate..<5, id: \.self) { _ in
                starImage
                    .foregroundStyle(Color(CPColor.gray2))
            }
        }
    }
    
    var starImage: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 16, height: 16)
    }
}

#Preview {
    DetailRateView(viewModel: DetailRateViewModel(rate: 4))
}
