//
//  MoreTableViewCell.swift
//  KTV
//
//  Created by 엄태양 on 3/6/24.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    static let height: CGFloat = 48
    static let identifier: String = "MoreTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(_ item: MoreItem, separatorHidden: Bool) {
        self.titleLabel.text = item.title
        if let rightText = item.rightText {
            self.rightTextLabel.text = rightText
        } else {
            self.rightTextLabel.text = nil
        }
        self.separatorView.isHidden = separatorHidden
    }
    
}
