//
//  MyNavigationViewController.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import UIKit

class MyNavigationViewController: UINavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        self.topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
