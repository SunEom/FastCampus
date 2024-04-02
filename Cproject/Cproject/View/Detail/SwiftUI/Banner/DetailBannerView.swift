//
//  DetailBannerView.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import SwiftUI
import Kingfisher

struct DetailBannerView: View {
    @ObservedObject var viewModel: DetailBannerViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach (viewModel.imageUrls, id: \.self) { imageUrl in
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.never)
        
        
    }
}

#Preview {
    DetailBannerView(viewModel: DetailBannerViewModel(imageURls: [
        "https://picsum.photos/id/1/550/500",
        "https://picsum.photos/id/2/550/500",
        "https://picsum.photos/id/3/550/500",
        "https://picsum.photos/id/4/550/500",
        "https://picsum.photos/id/5/550/500",
    ]))
}
