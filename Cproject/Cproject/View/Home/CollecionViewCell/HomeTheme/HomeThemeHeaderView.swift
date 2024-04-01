//
//  HomeThemeHeaderView.swift
//  Cproject
//
//  Created by 엄태양 on 4/1/24.
//

import UIKit

class HomeThemeHeaderView: UICollectionReusableView {
    static let identifier: String = "HomeThemeHeaderView"
    
    @IBOutlet weak var themeHeaderLabel: UILabel!

    func setViewModel(_ viewModel: HomeThemeHeaderViewModel) {
        themeHeaderLabel.text = viewModel.headerText
    }
    
}
