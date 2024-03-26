//
//  SearchBar.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var shouldBecomeFirstResponder: Bool
    
    init(text: Binding<String>, shouldBecomeFirstResponder: Binding<Bool>) {
        self._text = text
        self._shouldBecomeFirstResponder = shouldBecomeFirstResponder
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, shouldBecomeFirstResponder: $shouldBecomeFirstResponder)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        updateSearchText(uiView, context: context)
        updateBecomeFirstResponder(uiView, context: context)
    }
    
    private func updateSearchText(_ searchBar: UISearchBar, context: Context) {
        context.coordinator.setSearchText(searchBar, text: text)
    }
    
    private func updateBecomeFirstResponder(_ searchBar: UISearchBar, context: Context) {
        guard searchBar.canBecomeFirstResponder else { return }
        
        DispatchQueue.main.async {
            if shouldBecomeFirstResponder {
                guard !searchBar.isFirstResponder else { return }
                searchBar.becomeFirstResponder()
            } else {
                guard searchBar.isFirstResponder else { return }
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

extension SearchBar {
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var shouldBecomeFirstResponder: Bool
        
        init(text: Binding<String>, shouldBecomeFirstResponder: Binding<Bool>) {
            self._text = text
            self._shouldBecomeFirstResponder = shouldBecomeFirstResponder
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.shouldBecomeFirstResponder = true
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            self.shouldBecomeFirstResponder = false
        }
        
        func setSearchText(_ searchBar: UISearchBar, text: String) {
            searchBar.text = text
        }
    }
}
