//
//  VideoViewControllerContainer.swift
//  KTV
//
//  Created by 엄태양 on 3/13/24.
//

import Foundation

protocol VideoViewControllerContainer {
    var videoViewController: VideoViewController? { get }
    func presentCurrentViewController()
}
