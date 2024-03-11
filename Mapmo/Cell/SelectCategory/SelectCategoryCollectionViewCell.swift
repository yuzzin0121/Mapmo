//
//  SelectCategoryCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import SnapKit

class SelectCategoryCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let markImageView = UIImageView()
    let titleLabel = UILabel()
    let recordCountLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderWidth = isSelected ? 2 : 0
            contentView.layer.borderColor = ColorStyle.mapmoBorderColor.cgColor
            contentView.backgroundColor = isSelected ? ColorStyle.mapmoBackgroundColor : ColorStyle.customBackgroundGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        [markImageView, titleLabel, recordCountLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        markImageView.snp.makeConstraints { make in
            make.size.equalTo(26)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(markImageView)
            make.leading.equalTo(markImageView.snp.trailing).offset(8)
            make.height.equalTo(14)
        }
        
        recordCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(14)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = ColorStyle.customBackgroundGray
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        markImageView.image = ImageStyle.mark
        titleLabel.design(text: "일상")
        recordCountLabel.design(text: "0")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
