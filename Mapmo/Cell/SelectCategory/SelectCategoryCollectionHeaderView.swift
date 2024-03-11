//
//  SelectCategoryCollectionHeaderView.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit
import SnapKit

class SelectCategoryCollectionHeaderView: UICollectionReusableView, ViewProtocol {
    
    private let titleLabel = UILabel()
    let addCategoryButton = UIButton()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    // MARK: - configure
    func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(addCategoryButton)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(16)
        }
        addCategoryButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
    }
    
    func configureView() {
        backgroundColor = ColorStyle.customWhite
        titleLabel.design(text: "카테고리를 선택해주세요", font: .pretendard(size: 20, weight: .bold))
        addCategoryButton.setImage(ImageStyle.customPlus, for: .normal)
        addCategoryButton.tintColor = ColorStyle.mapmoColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
