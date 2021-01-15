//
//  AppConstants.swift
//  KudaGo
//
//  Created by Николаев Никита on 13.01.2021.
//

import UIKit

struct Constants {
    
    struct API {
        static let pageSize = 20
    }
    
    struct CollectionViewSettings {
        static let itemsPerRow: CGFloat = 2
        static let inset: CGFloat = 20
        static let cellAspectRatio: CGFloat = 1.3
        static let cellCornerRadius: CGFloat = 8
    }
    
    struct Segues {
        static let toDetail = "toDetail"
    }
    
    struct ReuseIdentificators {
        static let collectionCell = "event"
    }
}
