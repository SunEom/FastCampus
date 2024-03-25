//
//  PhotoPickerService.swift
//  LMessenger
//
//  Created by 엄태양 on 3/20/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Combine

enum PhotoPickerError: Error  {
    case importFailed
}

protocol PhotoPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data
    func loadTransferable(from imageSelection: PhotosPickerItem) -> AnyPublisher<Data, ServiceError>
}

class PhotoPickerService: PhotoPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        
        guard let image = try await imageSelection.loadTransferable(type: Photoimage.self) else {
            throw PhotoPickerError.importFailed
        }
        
        return image.data
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem) -> AnyPublisher<Data, ServiceError> {
        Future { promise in
            imageSelection.loadTransferable(type: Photoimage.self) { result in
                switch result {
                    case let .success(image):
                        guard let data = image?.data else {
                            promise(.failure(PhotoPickerError.importFailed))
                            return
                        }
                        promise(.success(data))
                    case let .failure(error):
                        promise(.failure(error))
                }
            }
        }
        .mapError { ServiceError.error($0) }
        .eraseToAnyPublisher()
    }
}

class StubPhotoPickerService: PhotoPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        return Data()
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem) -> AnyPublisher<Data, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
