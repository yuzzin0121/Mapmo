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
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(30)
        }
    }
    override func configureView() {
        collectionView.backgroundColor = ColorStyle.customWhite
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: RecordCollectionViewCell.identifier)
    }
}


