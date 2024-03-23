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
    let placeStackView = UIStackView()
    let markImageView = UIImageView()
    let placeLabel = UILabel()
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
        placeLabel.text = "\(record.place.title)"
        addressLabel.text = "\(record.place.roadAddress)"
        visitDateLabel.text = DateFormatterManager.shared.formattedUpdatedDate(record.visitedAt)
        
        let image = record.isFavorite ? ImageStyle.heartFill : ImageStyle.heart
        heartButton.setImage(image, for: .normal)
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        contentView.addSubviews([recordThumbnilImageView, memoLabel, placeStackView, addressLabel, visitDateLabel, heartButton])
        [markImageView, placeLabel].forEach {
            placeStackView.addArrangedSubview($0)
        }
    }
    
    func configureLayout() {
        recordThumbnilImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.height.equalTo(95)
            make.width.equalTo(120)
            make.centerY.equalToSuperview()
        }
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(recordThumbnilImageView.snp.top).offset(2)
            make.leading.equalTo(recordThumbnilImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(14)
            make.height.equalTo(17)
        }
        placeStackView.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(6)
            make.leading.equalTo(recordThumbnilImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(14)
        }
        markImageView.snp.makeConstraints { make in
            make.size.equalTo(22)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(placeStackView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(memoLabel)
        }
        visitDateLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(addressLabel.snp.bottom).offset(4)
            make.leading.equalTo(memoLabel)
            make.trailing.equalTo(heartButton.snp.leading).offset(-14)
            make.bottom.equalTo(recordThumbnilImageView.snp.bottom).offset(-2)
            make.height.equalTo(14)
        }
        
        heartButton.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.bottom.equalTo(visitDateLabel)
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    func configureView() {
        recordThumbnilImageView.image = ImageStyle.emptyPhoto
        recordThumbnilImageView.layer.cornerRadius = 4
        recordThumbnilImageView.clipsToBounds = true
        memoLabel.design(font: .pretendard(size: 17, weight: .semiBold))
        placeStackView.design(axis: .horizontal, spacing: 3)
        markImageView.image = ImageStyle.mark
        markImageView.tintColor = ColorStyle.customGray
        
        placeLabel.design(font: .pretendard(size: 15, weight: .medium))
        addressLabel.design()
        visitDateLabel.design(textColor: ColorStyle.customGray, font: .pretendard(size: 13, weight: .light))
        
        heartButton.setImage(ImageStyle.heart, for: .normal)
        heartButton.tintColor = ColorStyle.customBlack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
