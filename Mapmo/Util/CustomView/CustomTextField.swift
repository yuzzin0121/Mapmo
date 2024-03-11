//
//  CustomTextField.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = ColorStyle.customBackgroundGray
        layer.cornerRadius = 12
        clipsToBounds = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }
}

