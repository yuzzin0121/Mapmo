//
//  CategoryColor.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

enum CategoryColor: Int, CaseIterable {
    case red
    case orange
    case yellow
    case lightGreen
    case green
    case skyBlue
    case blue
    case mapmo
    case purple
    case pink
    
    var name: String {
        switch self {
        case .red: return "markRed"
        case .orange: return "markOrange"
        case .yellow: return "markYellow"
        case .lightGreen: return "markLightGreen"
        case .green: return "markGreen"
        case .skyBlue: return "markSkyBlue"
        case .blue: return "markBlue"
        case .mapmo: return "markMapmo"
        case .purple: return "markPurple"
        case .pink: return "markPink"
        }
    }
}
