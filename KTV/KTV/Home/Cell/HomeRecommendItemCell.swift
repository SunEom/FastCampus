//
//  HomeRecommendItemCell.swift
//  KTV
//
//  Created by 엄태양 on 2/28/24.
//

import UIKit

class HomeRecommendItemCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var badgeContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let height: CGFloat = 70
    static let identifier: String = "HomeRecommendItemCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.cornerRadius = 3
        badgeContainerView.layer.cornerRadius = 3
        timeLabel.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
