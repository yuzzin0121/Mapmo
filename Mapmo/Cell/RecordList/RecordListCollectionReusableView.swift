//
//  RecordListCollectionReusableView.swift
//  Mapmo
//
//  Created by 조유진 on 3/23/24.
//

import UIKit

class RecordListCollectionReusableView: UICollectionReusableView {
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setData(count: Int) {
        countLabel.text = "\(count)개의 맵모를 좋아합니다"
    }
    
    func configureHierarchy() {
        addSubviews([countLabel])
    }
    
    func configureLayout() {
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = ColorStyle.customWhite
        countLabel.design(font: .pretendard(size: 15, weight: .semiBold))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
