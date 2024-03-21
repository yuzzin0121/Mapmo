//
//  UserDefaultManager.swift
//  Mapmo
//
//  Created by 조유진 on 3/22/24.
//

import Foundation

// singleton pattern
// 유일한 인스턴스를 하나만 생성
class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private init() { }
    
    enum UDKey: String, CaseIterable {
        case UserStatus
        case nickname
        case profileImageIndex
        case searchKeywords
        case likeCount
        case likeProductIds
    }
    
    let ud = UserDefaults.standard
    
    var UserStatus: Bool{
        get { ud.bool(forKey: UDKey.UserStatus.rawValue) }
        set { ud.set(newValue, forKey: UDKey.UserStatus.rawValue) }
    }
}
