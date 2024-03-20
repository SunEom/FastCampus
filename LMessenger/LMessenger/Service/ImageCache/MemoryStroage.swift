//
//  MemoryStroage.swift
//  LMessenger
//
//  Created by 엄태양 on 3/20/24.
//

import UIKit

protocol MemoryStroageType {
    func value(for key: String) -> UIImage?
    func store(for key: String, image: UIImage)
}

class MemoryStroage: MemoryStroageType {
    
    var cache = NSCache<NSString, UIImage>()
    
    func value(for key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
    
    func store(for key: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: key)) // cost 설정 가능
    }
}
