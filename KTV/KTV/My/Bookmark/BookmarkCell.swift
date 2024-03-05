//
//  BookmarkCell.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import UIKit

class BookmarkCell: UITableViewCell {

    static let height: CGFloat = 70
    static let identifier: String = "BookmarkCell"
    
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    
    private var imageTask: Task<Void, Never>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        channelImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.imageTask?.cancel()
        self.imageTask = nil
        self.channelLabel.text = nil
        self.channelImageView.image = nil
        self.channelImageView = nil
    }
    
    func setData(_ item: Bookmark.Item) {
        self.channelLabel.text = item.channel
        self.imageTask = self.channelImageView.loadImage(url: item.thumbnail)
    }
}
