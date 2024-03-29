//
//  SplashViewController.swift
//  Cproject
//
//  Created by 엄태양 on 3/29/24.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lottieAnimationView.play()
    }
    
}
