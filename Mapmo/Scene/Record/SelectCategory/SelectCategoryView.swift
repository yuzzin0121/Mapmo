//
//  SelectCategoryView.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit
import SnapKit

class SelectCategoryView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let nextButton = MapmoButton()
    
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: 300, height: 50)
        layout.minimumInteritemSpacing = 12
        
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(nextButton)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }
    override func configureView() {
        collectionView.register(SelectCategoryCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectCategoryCollectionHeaderView.identifier)
        collectionView.register(SelectCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SelectCategoryCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = ColorStyle.customWhite

        nextButton.setTitle("다음으로", for: .normal)
    }
}
