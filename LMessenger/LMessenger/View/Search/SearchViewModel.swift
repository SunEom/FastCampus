//
//  SearchViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    enum Action {
        case requestQuery(String)
        case clearSearchResult
        case clearSearchText
    }
    
    @Published var searchText: String = ""
    @Published var searchResult: [User] = []
    @Published var shouldBecomeFirstResponder: Bool = false
    
    private let userId: String
    private let container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(userId: String, container: DIContainer) {
        self.userId = userId
        self.container = container
        
        bind()
    }
    
    func bind() {
        $searchText
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                if text.isEmpty {
                    self?.send(action: .clearSearchResult)
                } else {
                    self?.send(action: .requestQuery(text))
                }
            }.store(in: &subscriptions)
    }
    
    func send(action: Action) {
        switch action {
            case let .requestQuery(query):
                container.services.userService.filterUsers(with: query, userId: userId)
                    .sink { completion in
                    } receiveValue: { [weak self] users in
                        self?.searchResult = users
                    }.store(in: &subscriptions)
                
            case .clearSearchResult:
                self.searchResult = []
                
            case .clearSearchText:
                searchText = ""
                shouldBecomeFirstResponder = false
                searchResult = []
        }
    }
    
}
