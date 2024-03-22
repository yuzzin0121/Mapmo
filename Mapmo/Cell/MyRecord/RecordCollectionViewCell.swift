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
    let memoLabel = UILabel()
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
    
    func configureCell(record: RecordItem?) {
        guard let record = record else { return }
        guard let thumbnailImage = record.images.first else { return }
        recordThumbnilImageView.image = thumbnailImage
        memoLabel.text = record.memo
        markImageView.tintColor = UIColor(named: record.category.colorName)
        addressLabel.text = "\(record.place.title) | \(record.place.roadAddress)"
        visitDateLabel.text = DateFormatterManager.shared.formattedUpdatedDate(record.visitedAt)
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        contentView.addSubviews([recordThumbnilImageView, memoLabel, addressStackView, visitDateLabel, heartButton])
        [markImageView, addressLabel].forEach {
            addressStackView.addArrangedSubview($0)
        }
    }
    
    func configureLayout() {
        recordThumbnilImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.height.equalTo(90)
            make.width.equalTo(120)
            make.centerY.equalToSuperview()
        }
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(recordThumbnilImageView.snp.top).offset(4)
            make.leading.equalTo(recordThumbnilImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(14)
            make.height.equalTo(16)
        }
        addressStackView.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(6)
            make.leading.equalTo(recordThumbnilImageView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(14)
        }
        markImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        addressLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        visitDateLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(addressStackView.snp.bottom).offset(8)
            make.leading.equalTo(memoLabel)
            make.trailing.equalTo(heartButton.snp.leading).offset(-14)
            make.bottom.equalTo(recordThumbnilImageView.snp.bottom).offset(-4)
            make.height.equalTo(14)
        }
        
        heartButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.bottom.equalTo(visitDateLabel)
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    func configureView() {
        recordThumbnilImageView.image = ImageStyle.emptyPhoto
        recordThumbnilImageView.layer.cornerRadius = 4
        recordThumbnilImageView.clipsToBounds = true
        memoLabel.design(font: .pretendard(size: 16, weight: .semiBold))
        addressStackView.design(axis: .horizontal, spacing: 2)
        markImageView.image = ImageStyle.mark
        markImageView.tintColor = ColorStyle.customGray
        
        addressLabel.design(numberOfLines: 2)
        visitDateLabel.design(textColor: ColorStyle.customGray, font: .pretendard(size: 14, weight: .regular))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
