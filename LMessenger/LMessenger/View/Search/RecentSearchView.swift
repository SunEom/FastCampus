//
//  RecentSearchView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import SwiftUI

struct RecentSearchView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var result: FetchedResults<SearchResult>
    @Environment(\.managedObjectContext) var objectContext
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
                .padding(.bottom, 20)
            
            if result.isEmpty {
                Text("검색 내역이 없습니다.")
                    .font(.system(size: 10))
                    .foregroundColor(.greyDeep)
                    .padding(.vertical, 54)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(result, id: \.self) { result in
                            HStack {
                                Text(result.name ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(.bkText)
                                Spacer()
                                Button {
                                    objectContext.delete(result)
                                    try? objectContext.save()
                                } label: {
                                    Image("close_search")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }
    
    var titleView: some View {
        HStack {
            Text("최근 검색어")
                .font(.system(size: 10, weight: .bold))
            Spacer()
        }
    }
}

#Preview {
    RecentSearchView()
}
