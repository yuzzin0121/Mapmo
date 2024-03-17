//
//  MyRecordView.swift
//  Mapmo
//
//  Created by 조유진 on 3/18/24.
//

import UIKit
import FSCalendar

class MyRecordView: BaseView {
    let calendar = FSCalendar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func configureHierarchy() {
        addSubviews([calendar, collectionView])
    }
    override func configureLayout() {
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(280)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(14)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    override func configureView() {
        
        collectionView.backgroundColor = .gray
    }
}
