//
//  CreateRecordView.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

class CreateRecordView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let createButton = MapmoButton()
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(createButton)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(createButton.snp.top).offset(-16)
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = ColorStyle.customWhite
        collectionView.register(AddPhotoCollectionViewCell.self, forCellWithReuseIdentifier: AddPhotoCollectionViewCell.identifier)
        collectionView.register(InputPlaceCollectionViewCell.self, forCellWithReuseIdentifier: InputPlaceCollectionViewCell.identifier)
        collectionView.register(InputVisitedDateCollectionViewCell.self, forCellWithReuseIdentifier: InputVisitedDateCollectionViewCell.identifier)
        collectionView.register(InputMemoCollectionViewCell.self, forCellWithReuseIdentifier: InputMemoCollectionViewCell.identifier)

        createButton.setTitle("생성하기", for: .normal)
    }
}
