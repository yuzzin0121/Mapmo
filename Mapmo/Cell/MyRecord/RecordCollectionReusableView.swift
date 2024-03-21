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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setData(count: Int) {
        if count == 0 {
            countLabel.text = ""
        } else {
            countLabel.text = "\(count)개의 맵모"
        }
    }
    
    func configureHierarchy() {
        addSubviews([countLabel])
    }
    
    func configureLayout() {
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
        }
    }
    
    func configureView() {
        backgroundColor = ColorStyle.customWhite
        countLabel.design(font: .pretendard(size: 15, weight: .semiBold))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
