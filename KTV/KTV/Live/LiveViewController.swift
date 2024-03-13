//
//  LiveViewController.swift
//  KTV
//
//  Created by 엄태양 on 3/8/24.
//

import UIKit

class LiveViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: LiveViewModel = .init()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.containerView.layer.cornerRadius = 15
        self.containerView.layer.borderColor = UIColor(named: "gray-2")?.cgColor
        self.containerView.layer.borderWidth = 1
        
        self.setupCollectionView()
        self.bindViewMOdel()
        
        self.viewModel.request(sort: .favorite)
    }
    
    
    @IBAction func sortDidTap(_ sender: UIButton) {
        guard sender.isSelected == false else {
            return
        }
        
        self.favoriteButton.isSelected = sender == self.favoriteButton
        self.startTimeButton.isSelected = sender == self.startTimeButton
        
        if self.favoriteButton.isSelected {
            self.viewModel.request(sort: .favorite)
        } else {
            self.viewModel.request(sort: .start)
        }
    }
    
    func setupCollectionView() {
        self.collectionView.register(
            UINib(nibName: LiveCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: LiveCell.identifier
        )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func bindViewMOdel() {
        self.viewModel.dataChanged = { [weak self] _ in
            self?.collectionView.reloadData()
            self?.collectionView.setContentOffset(.zero, animated: true)
//            if $0.isEmpty == false {
//                self?.collectionView.scrollToItem(
//                    at: IndexPath(
//                        item: 0,
//                        section: 0
//                    ),
//                    at: .top,
//                    animated: true
//                )
//            }
        }
    }
}

extension LiveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: LiveCell.height)
    }
}

extension LiveViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LiveCell.identifier,
            for: indexPath
        )
        
        if let cell = cell as? LiveCell,
           let data = self.viewModel.items?[indexPath.item] {
            cell.setData(data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = (self.tabBarController as? VideoViewControllerContainer)?.videoViewController {
            (self.tabBarController as? VideoViewControllerContainer)?.presentCurrentViewController()
        } else {
            let vc = VideoViewController()
            vc.isLiveMode = true
            vc.delegate = self.tabBarController as? VideoViewControllerDelegate
            self.present(vc, animated: true)
        }
    }
}
