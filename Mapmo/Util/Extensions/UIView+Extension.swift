//
//  UIView+Extension.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
