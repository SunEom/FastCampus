//
//  PhotoPickerService.swift
//  LMessenger
//
//  Created by 엄태양 on 3/20/24.
//

import Foundation
import SwiftUI
import PhotosUI

enum PhotoPickerError: Error  {
    case importFailed
}

protocol PhotoPickerServiceType {
    func loadTransferable(from imageSeleciton: PhotosPickerItem) async throws -> Data
}

class PhotoPickerService: PhotoPickerServiceType {
    func loadTransferable(from imageSeleciton: PhotosPickerItem) async throws -> Data {
        
        guard let image = try await imageSeleciton.loadTransferable(type: Photoimage.self) else {
            throw PhotoPickerError.importFailed
        }
        
        return image.data
    }
}

class StubPhotoPickerService: PhotoPickerServiceType {
    func loadTransferable(from imageSeleciton: PhotosPickerItem) async throws -> Data {
        return Data()
    }
}
