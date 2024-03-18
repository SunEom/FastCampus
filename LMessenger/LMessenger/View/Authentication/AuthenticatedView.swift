//
//  AuthenticatedView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init())
}
