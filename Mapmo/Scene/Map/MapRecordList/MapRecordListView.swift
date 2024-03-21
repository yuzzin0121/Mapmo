//
//  MapRecordListView.swift
//  Mapmo
//
//  Created by 조유진 on 3/16/24.
//

import UIKit
import SnapKit

class MapRecordListView: BaseView {
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
        collectionView.backgroundColor = ColorStyle.customWhite
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: RecordCollectionViewCell.identifier)
        
        emptyMessaageLabel.design(text: "+ 버튼을 눌러 맵모를 남겨보세요", textColor: ColorStyle.customGray, font: .pretendard(size: 18, weight: .regular))
    }
}


