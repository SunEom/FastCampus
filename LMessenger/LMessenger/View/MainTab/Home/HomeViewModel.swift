//
//  HomeViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/19/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = [.stub1, .stub2]
}
