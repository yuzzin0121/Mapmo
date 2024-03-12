//
//  InputRecordSection.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

enum InputRecordSection: Int, CaseIterable {
    case photo
    case place
    case visitDate
    case memo
    
    var title: String {
        switch self {
        case .photo: return "이미지"
        case .place: return "장소"
        case .visitDate: return "방문 날짜"
        case .memo: return "메모"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .photo: return ImageStyle.photo
        case .place: return ImageStyle.mark
        case .visitDate: return ImageStyle.history
        case .memo: return ImageStyle.memo
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .photo: return 250
        case .place: return 96
        case .visitDate: return 100
        case .memo: return 264
        }
    }
}
