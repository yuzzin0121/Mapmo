//
//  SelectCategoryColorCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

final class SelectCategoryColorCollectionViewCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderWidth = isSelected ? 4 : 0
            contentView.layer.borderColor = ColorStyle.null.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = contentView.frame.height / 2.5
    }
}
