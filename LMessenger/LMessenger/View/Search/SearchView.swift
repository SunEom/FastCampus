//
//  SearchView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {
            topView
            
            List {
                ForEach(viewModel.searchResult) { result in
                    HStack(spacing: 8) {
                        URLImageView(urlString: result.profileURL)
                            .frame(width: 26, height: 26)
                            .clipShape(Circle())
                        Text(result.name)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.bkText)
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .padding(.horizontal, 30)
                }
            }
            .listStyle(.plain)
            
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    var topView: some View {
        HStack(spacing: 0) {
            Button {
                navigationRouter.pop()
            } label: {
                Image("back")
            }
            
            SearchBar(
                text: $viewModel.searchText,
                shouldBecomeFirstResponder: $viewModel.shouldBecomeFirstResponder
            )
            
            Button {
                self.viewModel.send(action: .clearSearchText)
            } label: {
                Image("close_search")
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchView(viewModel: .init(userId: "user1_id", container: .init(services: StubService())))
}
