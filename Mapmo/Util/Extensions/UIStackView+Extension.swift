//
//  UIStackView+Extension.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

extension UIStackView {
    func design(axis: NSLayoutConstraint.Axis = .vertical,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                spacing: CGFloat = 4
    ) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
