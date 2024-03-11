//
//  SelectCategoryColorCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

class SelectCategoryColorCollectionViewCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override var isSelected: Bool {
        didSet {
            print(isSelected)
            contentView.layer.borderWidth = isSelected ? 2 : 0
            contentView.layer.borderColor = UIColor.gray.cgColor
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
