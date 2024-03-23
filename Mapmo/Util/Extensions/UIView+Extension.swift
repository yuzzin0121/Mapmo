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

extension UIView {
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds

        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        gradientLayer.locations = [0.0, 1.0]

        // 그레디언트 방향 설정 (위에서 아래로)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.6)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        // 뷰의 배경으로 그레디언트 레이어 추가
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
