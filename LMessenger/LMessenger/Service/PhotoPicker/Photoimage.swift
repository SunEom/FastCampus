//
//  Photoimage.swift
//  LMessenger
//
//  Created by 엄태양 on 3/20/24.
//

import SwiftUI

struct Photoimage: Transferable {
    let data: Data
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw PhotoPickerError.importFailed
            }
            
            guard let data = uiImage.jpegData(compressionQuality: 0.3) else {
                throw PhotoPickerError.importFailed
            }
            
            return Photoimage(data: data)
        }
    }
     
}
