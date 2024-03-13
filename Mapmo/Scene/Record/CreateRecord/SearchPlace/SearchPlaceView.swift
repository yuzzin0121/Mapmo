//
//  SearchPlaceView.swift
//  Mapmo
//
//  Created by 조유진 on 3/13/24.
//

import UIKit
import SnapKit

class SearchPlaceView: BaseView {
    let searchController = UISearchController(searchResultsController: nil)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(14)
        }
    }
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)

    }
}
