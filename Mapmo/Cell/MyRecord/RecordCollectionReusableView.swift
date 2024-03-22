//
//  RecordCollectionReusableView.swift
//  Mapmo
//
//  Created by 조유진 on 3/22/24.
//

import UIKit
import SnapKit

final class RecordCollectionReusableView: UICollectionReusableView, ViewProtocol {
    let countLabel = UILabel()
    let addRecordButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setData(count: Int) {
        countLabel.text = "\(count)개의 맵모"
    }
    
    func configureHierarchy() {
        addSubviews([countLabel, addRecordButton])
    }
    
    func configureLayout() {
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
        }
        addRecordButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(24)
        }
    }
    
    func configureView() {
        backgroundColor = ColorStyle.customWhite
        countLabel.design(font: .pretendard(size: 15, weight: .semiBold))
        addRecordButton.setImage(ImageStyle.rectPlus, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
