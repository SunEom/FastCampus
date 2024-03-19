//
//  DBError.swift
//  LMessenger
//
//  Created by 엄태양 on 3/19/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
