//
//  UserDBRepositoryTests.swift
//  LMessengerTests
//
//  Created by 엄태양 on 3/27/24.
//

import XCTest
import Combine
@testable import LMessenger

final class UserDBRepositoryTests: XCTestCase {

    private var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
    }

}
