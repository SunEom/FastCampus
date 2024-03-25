//
//  OtherProfileView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/19/24.
//

import SwiftUI

struct OtherProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: OtherProfileViewModel
    
    var gotoChat: (User) -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .vertical)
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    URLImageView(urlString: viewModel.userInfo?.profileURL)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.bottom, 16)
                    
                    Text(viewModel.userInfo?.name ?? "이름")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 26)
                    
                    Spacer()
                    
                    menuView
                        .padding(.bottom, 58)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("close")
                    }
                }
            }
            .task { // onAppear 직전에 호출
                await viewModel.getUser()
            }
        }
        
    }
    
    var menuView: some View {
        HStack(alignment: .top, spacing: 27)  {
            ForEach(OtherProfileMenuType.allCases, id: \.self) { menu in
                Button {
                    if menu == .chat, let userInfo = viewModel.userInfo {
                        dismiss()
                        gotoChat(userInfo)
                    }
                } label: {
                    VStack(alignment: .center) {
                        Image(menu.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text(menu.description)
                            .font(.system(size: 10))
                            .foregroundColor(.bgWh)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    OtherProfileView(viewModel: .init(userId: "user1_id", container: DIContainer(services: StubService()))) { _ in
        
    }
}
