//
//  InputPlaceCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import SnapKit

final class InputPlaceCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let addressButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        [iconImageView, titleLabel, addressButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(6)
            make.centerY.equalTo(iconImageView)
            make.height.equalTo(16)
        }
        addressButton.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureView() {
        iconImageView.image = InputRecordSection.place.icon
        iconImageView.tintColor = ColorStyle.customGray
        titleLabel.design(text: InputRecordSection.place.title, font: .pretendard(size: 16, weight: .bold))
        
        addressButton.layer.cornerRadius = 12
        addressButton.backgroundColor = ColorStyle.customBackgroundGray
      
        addressButton.setTitle("장소 입력", for: .normal)
        addressButton.setTitleColor(ColorStyle.customGray, for: .normal)
        addressButton.titleLabel?.font = .pretendard(size: 16, weight: .semiBold)
        addressButton.contentHorizontalAlignment = .left
        addressButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
