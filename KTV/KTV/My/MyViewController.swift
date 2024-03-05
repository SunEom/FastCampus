//
//  MyViewController.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.cornerRadius = 5
    }

    @IBAction func bookmarkButtonDidTap(_ sender: Any) {
        
    }
    
    @IBAction func favoriteButtonDidTap(_ sender: Any) {
        self.performSegue(withIdentifier: "favorite", sender: nil)
    }
}
