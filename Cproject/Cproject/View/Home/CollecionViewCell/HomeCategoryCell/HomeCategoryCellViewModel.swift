//
//  HomeCategoryCellViewModel.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import UIKit

enum Category: CaseIterable {
    case fashion
    case food
    case living
    case digital
    case sports
    case pet
    case party
    case furniture
    
    func getTitle() -> String {
        switch self {
            case .fashion:
                return "패션"
            case .food:
                return "식품"
            case .living:
                return "생활용품"
            case .digital:
                return "가전디지털"
            case .sports:
                return "스포츠"
            case .pet:
                return "반려동물"
            case .party:
                return "파티용품"
            case .furniture:
                return "가구"
        }
    }
    
    func getBigImage() -> UIImage {
        switch self {
            case .fashion:
                return CPImage.category1Big
            case .food:
                return CPImage.category2Big
            case .living:
                return CPImage.category3Big
            case .digital:
                return CPImage.category4Big
            case .sports:
                return CPImage.category5Big
            case .pet:
                return CPImage.category6Big
            case .party:
                return CPImage.category7Big
            case .furniture:
                return CPImage.category8Big
        }
    }
}

struct HomeCategoryCellViewModel: Hashable {
    let category: Category
}
