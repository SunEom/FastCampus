//
//  NavigationRoutingView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
            case .chat:
                ChatView()
            case .search:
                SearchView()
        }
    }
}

#Preview {
    NavigationRoutingView(destination: .search)
}
