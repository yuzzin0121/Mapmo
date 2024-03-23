//
//  RecordListView.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit
import SnapKit

final class RecordListView: BaseView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let emptyMessaageLabel = UILabel()
    
    
    override func configureHierarchy() {
        addSubviews([collectionView, emptyMessaageLabel])
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        emptyMessaageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    override func configureView() {
        backgroundColor = ColorStyle.customWhite
        collectionView.backgroundColor = ColorStyle.customWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(RecordListCollectionViewCell.self, forCellWithReuseIdentifier: RecordListCollectionViewCell.identifier)
        collectionView.register(RecordListCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecordListCollectionReusableView.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        emptyMessaageLabel.design(text: "하트를 클릭하여 좋아하는 맵모를\n 저장해보세요", textColor: ColorStyle.customGray, font: .pretendard(size: 17, weight: .regular), textAlignment: .center, numberOfLines: 2)
    }
}
