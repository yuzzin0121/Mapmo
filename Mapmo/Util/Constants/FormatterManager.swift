//
//  FormatterManager.swift
//  Mapmo
//
//  Created by 조유진 on 3/18/24.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()
    private init() { }
    private let dateFormatter = DateFormatter()
    
    func formattedUpdatedDate(_ date: Date) -> String? {
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
    }
    
    func formattedVisitedDate(_ date: Date) -> String? {
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a hh시 mm분"
        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
    }
}
