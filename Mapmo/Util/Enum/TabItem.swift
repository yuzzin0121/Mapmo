//
//  UITabItem.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit

enum TabItem {
    case map
    case list
    case history
    
    var title: String {
        switch self {
        case .map: return "지도"
        case .list: return "좋아요한 맵모"
        case .history: return "히스토리"
        }
    }
    
    var image: UIImage {
        switch self {
        case .map: return ImageStyle.map
        case .list: return ImageStyle.heartFill
        case .history: return ImageStyle.history
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .map: return ImageStyle.mapFill
        case .list: return ImageStyle.heartFill
        case .history: return ImageStyle.selectedHistory
        }
    }
}
