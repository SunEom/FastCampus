//
//  DetailOptionView.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import SwiftUI
import Kingfisher

struct DetailOptionView: View {
    @ObservedObject var viewModel: DetailOptionViewModel
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text(viewModel.type)
                    .foregroundStyle(Color(CPColor.gray5))
                    .font(Font(CPFont.r12))
                
                Text(viewModel.name)
                    .foregroundStyle(Color(CPColor.bk))
                    .font(Font(CPFont.b14))
                
            }
            
            Spacer()
            
            KFImage(URL(string: viewModel.imageUrl))
                .resizable()
                .frame(width: 40, height: 40)
                
        }
    }
}

#Preview {
    DetailOptionView(viewModel: DetailOptionViewModel(
        type: "색상", 
        name: "코랄",
        imageUrl: "https://picsum.photos/id/1/500/500"
    ))
}
