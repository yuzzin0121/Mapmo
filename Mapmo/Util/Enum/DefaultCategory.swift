//
//  Category.swift
//  Mapmo
//
//  Created by 조유진 on 3/22/24.
//

import Foundation

enum DefaultCategory {
    case life
    case cafe
    case matzip
    
    var title: String {
        switch self {
        case .life: return "일상"
        case .cafe: return "카페"
        case .matzip: return "맛집"
        }
    }
    
    var colorName: String {
        switch self {
        case .life: return "markGreen"
        case .cafe: return "markMapmo"
        case .matzip: return "markYellow"
        }
    }
}
