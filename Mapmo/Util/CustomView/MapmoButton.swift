//
//  MapmoButton.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

final class MapmoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = ColorStyle.null
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}
