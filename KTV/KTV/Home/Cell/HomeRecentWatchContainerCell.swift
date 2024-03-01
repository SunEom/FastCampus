//
//  HomeRecentWatchContainerCell.swift
//  KTV
//
//  Created by 엄태양 on 2/28/24.
//

import UIKit

protocol HomeRecentWatchContainerDelegate: AnyObject {
    func homeRecentWatchItemCell(_ cell: HomeRecentWatchContainerCell, _ indexPath: Int)
}

class HomeRecentWatchContainerCell: UICollectionViewCell {

    static let identifier: String = "HomeRecentWatchContainerCell"
    static let height: CGFloat = 209
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: HomeRecentWatchContainerDelegate?
    private var recents: [Home.Recent]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(
            UINib(nibName: HomeRecentWatchItemCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeRecentWatchItemCell.identifier
        )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.layer.cornerRadius = 10
        self.collectionView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.collectionView.layer.borderWidth = 1
    }
    
    func setData(_ data: [Home.Recent]) {
        self.recents = data
        self.collectionView.reloadData()
    }
    
}

extension HomeRecentWatchContainerCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRecentWatchItemCell.identifier,
            for: indexPath
        )
        
        if let cell = cell as? HomeRecentWatchItemCell,
           let data = self.recents?[indexPath.item] {
            cell.setData(data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.homeRecentWatchItemCell(self, indexPath.row)
    }
    
}
