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
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewFlowLayout())
    
    let emptyStackView = UIStackView()
    let emptyPhotoImageView = UIImageView()
    let emptyMessageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setEmptyUI(_ isEmpty: Bool) {
        emptyStackView.isHidden = !isEmpty
    }
    
    func configureCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let width = (contentView.frame.width - 40 - 16) / 2
        print(width)
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumInteritemSpacing = 16
        return layout
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        [iconImageView, titleLabel, addPhotoButton, collectionView, emptyStackView].forEach {
            contentView.addSubview($0)
        }
        [emptyPhotoImageView, emptyMessageLabel].forEach {
            emptyStackView.addArrangedSubview($0)
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
        
        emptyStackView.snp.makeConstraints { make in
            make.centerY.equalTo(collectionView)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emptyPhotoImageView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(70)
        }
        emptyMessageLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
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
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        emptyStackView.design(spacing: 12)
        
        emptyPhotoImageView.image = ImageStyle.emptyPhoto
        emptyPhotoImageView.contentMode = .scaleAspectFit
        emptyPhotoImageView.tintColor = ColorStyle.customGray
        
        emptyMessageLabel.design(text: "아직 등록된 사진이 없어요", textColor: ColorStyle.customGray, font: .pretendard(size: 16, weight: .semiBold), textAlignment: .center)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
