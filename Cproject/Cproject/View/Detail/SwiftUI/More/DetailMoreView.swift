//
//  DetailMoreView.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import SwiftUI

struct DetailMoreView: View {
    @ObservedObject var viewModel:DetailMoreViewModel
    
    var onMoreTapped: () -> Void
    
    var body: some View {
        Button {
            onMoreTapped()
        } label: {
            HStack(alignment: .center, spacing: 5) {
                Text("상품정보 더보기")
                    .font(Font(CPFont.b17))
                    .foregroundStyle(Color(CPColor.keyColorBlue))
                
                Image(.down)
                    .foregroundStyle(Color(CPColor.icon))
            }
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .border(Color(CPColor.keyColorBlue), width: 1)
        }
        
    }
}

#Preview {
    DetailMoreView(viewModel: .init()) {
        
    }
}
