//
//  Double+Extension.swift
//  Mapmo
//
//  Created by 조유진 on 3/18/24.
//

import Foundation

extension Double {
    func convertToCoordinate() -> Double {
        return self / 10_000_000.0
    }
}
