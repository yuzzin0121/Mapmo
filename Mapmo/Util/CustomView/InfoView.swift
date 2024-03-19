//
//  InfoView.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit
import SnapKit

class InfoView: UIView, ViewProtocol {
    
    let titleLabel = UILabel()
    let valueBackgroundView = UIView()
    let iconImageView = UIImageView()
    let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        addSubviews([titleLabel, valueBackgroundView])
        [iconImageView, valueLabel].forEach {
            valueBackgroundView.addSubview($0)
        }
    }
    
    // InfoView의 높이 - 17 + 40
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(17)
        }
        valueBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(valueBackgroundView)
            make.leading.equalTo(12)
            make.size.equalTo(20)
        }
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(valueBackgroundView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(16)
        }
    }
    
    func configureView() {
        titleLabel.design(font: .pretendard(size: 17, weight: .semiBold))
        valueBackgroundView.backgroundColor = ColorStyle.customBackgroundGray
        valueBackgroundView.layer.cornerRadius = 12
        valueBackgroundView.clipsToBounds = true
        iconImageView.image = ImageStyle.mark
        valueLabel.design(font: .pretendard(size: 16, weight: .regular))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
