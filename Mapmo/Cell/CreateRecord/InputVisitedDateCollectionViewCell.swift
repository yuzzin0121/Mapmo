//
//  InputVisitedDateCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

final class InputVisitedDateCollectionViewCell: UICollectionViewCell {
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        [iconImageView, titleLabel, datePicker].forEach {
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
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureView() {
        iconImageView.image = InputRecordSection.visitDate.icon
        titleLabel.design(text: InputRecordSection.visitDate.title, font: .pretendard(size: 16, weight: .bold))
        datePicker.locale = Locale(identifier: "ko_KR")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
