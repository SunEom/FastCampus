//
//  SearchView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.managedObjectContext) var objectContext
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {
            topView
            
            if viewModel.searchResult.isEmpty {
                RecentSearchView()
            } else {
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
            
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    var topView: some View {
        HStack(spacing: 0) {
            Button {
                container.navigationRouter.pop()
            } label: {
                Image("back")
            }
            
            SearchBar(
                text: $viewModel.searchText,
                shouldBecomeFirstResponder: $viewModel.shouldBecomeFirstResponder) {
                    setSearchResultWithContext()
                }
            
            Button {
                self.viewModel.send(action: .clearSearchText)
            } label: {
                Image("close_search")
            }
        }
        .padding(.horizontal, 20)
    }
    
    func setSearchResultWithContext() {
        let result = SearchResult(context: objectContext)
        result.id = UUID().uuidString
        result.name = viewModel.searchText
        result.date = .now
        
        try? objectContext.save()
    }
}

#Preview {
    SearchView(viewModel: .init(userId: "user1_id", container: .init(services: StubService())))
}
