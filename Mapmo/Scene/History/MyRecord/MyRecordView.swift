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
    let emptyMessaageLabel = UILabel()
    
    
    override func configureHierarchy() {
        addSubviews([calendar, collectionView])
        collectionView.addSubview(emptyMessaageLabel)
    }
    override func configureLayout() {
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(280)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        emptyMessaageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = ColorStyle.customWhite
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: RecordCollectionViewCell.identifier)
        collectionView.register(RecordCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecordCollectionReusableView.identifier)
        
        emptyMessaageLabel.design(text: "+ 버튼을 클릭하여 맵모를 남겨보세요", textColor: ColorStyle.customGray, font: .pretendard(size: 17, weight: .regular))
        
        calendar.locale = Locale(identifier: "ko_KR")
        
        calendar.appearance.weekdayFont = .pretendard(size: 15, weight: .regular)
        calendar.appearance.weekdayTextColor = ColorStyle.customBlack
        calendar.appearance.titleFont = .pretendard(size: 15, weight: .regular)
        calendar.appearance.eventSelectionColor = ColorStyle.mapmoColor
        
        // 헤더 설정
        calendar.appearance.headerTitleFont = .pretendard(size: 20, weight: .semiBold)
        calendar.appearance.headerTitleColor = ColorStyle.customBlack
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "yyyy년 MM월"
        
        calendar.appearance.titleDefaultColor = ColorStyle.customBlack
        
        calendar.appearance.todayColor = ColorStyle.mapmoBorderColor
        calendar.appearance.selectionColor = ColorStyle.mapmoColor
    }
}
