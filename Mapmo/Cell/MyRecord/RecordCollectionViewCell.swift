//
//  RecordCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/18/24.
//

import UIKit
import SnapKit

final class RecordCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let recordThumbnilImageView = UIImageView()
    let titleLabel = UILabel()
    let addressStackView = UIStackView()
    let markImageView = UIImageView()
    let addressLabel = UILabel()
    let visitDateLabel = UILabel()
    let heartButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        recordThumbnilImageView.image = nil
    }
    
    func configureCell(record: Record?) {
        guard let record = record else { return }
        titleLabel.text = record.title
        
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        contentView.addSubviews([recordThumbnilImageView, titleLabel, addressStackView, visitDateLabel, heartButton])
        [markImageView, addressLabel].forEach {
            addressStackView.addArrangedSubview($0)
        }
    }
    
    func configureLayout() {
        recordThumbnilImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(130)
            make.width.equalTo(180)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recordThumbnilImageView.snp.top).offset(12)
            make.leading.equalTo(recordThumbnilImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(16)
        }
        addressStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(12)
        }
        markImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        visitDateLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(addressStackView.snp.bottom).offset(12)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(heartButton.snp.leading).offset(-12)
            make.bottom.equalTo(recordThumbnilImageView.snp.bottom).offset(-4)
            make.height.equalTo(14)
        }
        
        heartButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.bottom.equalTo(visitDateLabel)
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    func configureView() {
        recordThumbnilImageView.image = ImageStyle.emptyPhoto
        titleLabel.design(font: .pretendard(size: 16, weight: .semiBold))
        addressStackView.design(axis: .horizontal)
        markImageView.image = ImageStyle.mark
        markImageView.tintColor = ColorStyle.customGray
        
        addressLabel.design()
        visitDateLabel.design(textColor: ColorStyle.customGray, font: .pretendard(size: 14, weight: .regular))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
