//
//  AddPhotoCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit
import SnapKit

final class AddPhotoCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let addPhotoButton = UIButton()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let emptyPhotoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        [iconImageView, titleLabel, addPhotoButton, collectionView].forEach {
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
        addPhotoButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalTo(iconImageView)
            make.trailing.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureView() {
        iconImageView.image = InputRecordSection.photo.icon
        titleLabel.design(text: InputRecordSection.photo.title, font: .pretendard(size: 16, weight: .bold))
        addPhotoButton.setImage(ImageStyle.customPlus, for: .normal)
        addPhotoButton.tintColor = ColorStyle.mapmoColor
        
        collectionView.backgroundColor = ColorStyle.customBackgroundGray
        collectionView.layer.cornerRadius = 12
        collectionView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
