//
//  DetailViewController.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import UIKit
import SwiftUI

final class DetailViewController: UIViewController {
    
    let viewModel: DetailViewModel = .init()
    lazy var rootView: UIHostingController = UIHostingController(rootView: DetailRootView(viewModel: self.viewModel))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRootView()
    }
    
    private func addRootView() {
        addChild(rootView)
        view.addSubview(rootView.view)
        
        rootView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rootView.view.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
