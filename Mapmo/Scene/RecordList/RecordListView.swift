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
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(RecordListCollectionViewCell.self, forCellWithReuseIdentifier: RecordListCollectionViewCell.identifier)
        collectionView.register(RecordListCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecordListCollectionReusableView.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
