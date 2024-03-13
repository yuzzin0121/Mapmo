//
//  PlaceCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import UIKit
import SnapKit

class PlaceCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let locationImageView = UIImageView()
    let placeStackView = UIStackView()
    let placeLabel = UILabel()
    let addressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        [locationImageView, placeStackView].forEach {
            contentView.addSubview($0)
        }
        [placeLabel, addressLabel].forEach {
            placeStackView.addArrangedSubview($0)
        }
    }
    
    func configureLayout() {
        locationImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.size.equalTo(32)
        }
        placeStackView.snp.makeConstraints { make in
            make.leading.equalTo(locationImageView.snp.trailing).offset(14)
            make.centerY.equalTo(locationImageView)
            make.trailing.equalToSuperview().inset(12)
        }
        placeLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        addressLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
    }
    
    func configureView() {
        locationImageView.image = ImageStyle.mark
        placeStackView.design()
        placeLabel.design(font: .pretendard(size: 16, weight: .semiBold))
        addressLabel.design(textColor: ColorStyle.customGray, font: .pretendard(size: 15, weight: .regular))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
