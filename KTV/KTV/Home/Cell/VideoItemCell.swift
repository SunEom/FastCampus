//
//  VideoItemCell.swift
//  KTV
//
//  Created by 엄태양 on 2/28/24.
//

import UIKit

class VideoItemCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titlelLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let height: CGFloat = 70
    static let identifier: String = "VideoItemCell"
    
    private static let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
    
    private var imageTask: Task<Void, Never>?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.cornerRadius = 5
        rankLabel.layer.cornerRadius = 5
        rankLabel.clipsToBounds = true
        timeLabel.layer.cornerRadius = 3
        timeLabel.clipsToBounds = true
        
        self.backgroundConfiguration = .clear()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: VideoListItem, rank: Int? ){
        self.rankLabel.isHidden = rank == nil
        if let rank {
            self.rankLabel.text = "\(rank)"
        }
        self.titlelLabel.text = data.title
        self.subtitleLabel.text = data.channel
        self.timeLabel.text = Self.timeFormatter.string(
            from: data.playtime
        )
        self.imageTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
    }

}
