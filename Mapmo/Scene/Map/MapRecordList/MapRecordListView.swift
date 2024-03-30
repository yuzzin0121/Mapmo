//
//  MapRecordListView.swift
//  Mapmo
//
//  Created by 조유진 on 3/16/24.
//

import UIKit
import SnapKit

final class MapRecordListView: BaseView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let emptyMessaageLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(emptyMessaageLabel)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(34)
        }
        emptyMessaageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalTo(collectionView)
        }
    }
    override func configureView() {
        backgroundColor = ColorStyle.customWhite
        collectionView.backgroundColor = ColorStyle.customWhite
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: RecordCollectionViewCell.identifier)
        collectionView.register(RecordCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecordCollectionReusableView.identifier)
        
        emptyMessaageLabel.design(text: "+ 버튼을 클릭하여 맵모를 남겨보세요", textColor: ColorStyle.customGray, font: .pretendard(size: 17, weight: .regular))
    }
}


