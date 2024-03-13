//
//  TabbarController.swift
//  KTV
//
//  Created by 엄태양 on 2/28/24.
//

import UIKit

class TabbarController: UITabBarController, VideoViewControllerDelegate, VideoViewControllerContainer {
    weak var videoViewController: VideoViewController?
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func videoViewController(_ videoViewController: VideoViewController, yPositionForMinimizeView height: CGFloat) -> CGFloat {
        return self.tabBar.frame.minY - height
    }
    
    func videoViewControllerDidMinimize(_ videoViewController: VideoViewController) {
        self.videoViewController = videoViewController
        self.addChild(videoViewController)
        self.view.addSubview(videoViewController.view)
        //auto Layout
        videoViewController.didMove(toParent: self)
    }
    
    func videoViewControllerNeedsMaximize(_ videoViewController: VideoViewController) {
        self.videoViewController = nil
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.present(videoViewController, animated: true)
    }
    
    func videoViewControllerDidTapClose(_ videoViewController: VideoViewController) {
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.videoViewController = nil
    }
    
    func presentCurrentViewController() {
        guard let videoViewController else {
            return
        }
        
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.present(videoViewController, animated: true)
        self.videoViewController = nil
    }


}
