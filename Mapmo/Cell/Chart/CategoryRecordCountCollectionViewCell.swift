//
//  CategoryRecordCountCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit
import SnapKit

final class CategoryRecordCountCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let titleLabel = UILabel()
    let firstCategoryStackView = UIStackView()
    let firstRankLabel = UILabel()
    
    let secondCategoryStackView = UIStackView()
    let secondRankLabel = UILabel()
    
    let thirdCategoryStackView = UIStackView()
    let thirdRankLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        addSubviews([titleLabel])
    }
    
    // 셀 높이 - 16 +
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
    }
    func configureView() {
        titleLabel.design(text: "가장 많이 사용한 카테고리", font: .pretendard(size: 24, weight: .black))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
