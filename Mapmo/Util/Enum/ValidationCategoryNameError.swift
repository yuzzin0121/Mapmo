//
//  ValidationCategoryNameError.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation


enum ValidationCategoryNameError: Error {
    case invalidateLength
    case isSpecialChars
    case overlap
    
    var message: String {
        switch self {
        case .invalidateLength:
            return "2글자 이상 15글자 미만으로 설정해주세요"
        case .isSpecialChars:
            return "@, #, $, %는 포함할 수 없어요"
        case .overlap:
            return "이미 존재하는 이름이에요"
        }
    }
}
