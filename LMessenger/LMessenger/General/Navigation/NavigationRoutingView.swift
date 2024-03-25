//
//  NavigationRoutingView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/25/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
            case let .chat(chatRoomId, myUserId, otherUserId):
                ChatView(viewModel: .init(
                    chatRoomId: chatRoomId,
                    myUserId: myUserId,
                    otherUserId: otherUserId,
                    container: container)
                )
            case .search:
                SearchView()
        }
    }
}

#Preview {
    NavigationRoutingView(destination: .search)
}
