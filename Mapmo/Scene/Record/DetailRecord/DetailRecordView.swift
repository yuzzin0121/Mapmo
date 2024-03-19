//
//  DetailRecordView.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit
import SnapKit

class DetailRecordView: BaseView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageScrollView = UIScrollView()
    let pageControl = UIPageControl()
    
    let placeInfoView = InfoView()
    let visitDateInfoView = InfoView()
    let memoInfoView = MemoInfoView()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([imageScrollView, placeInfoView, visitDateInfoView, memoInfoView])
    }
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        imageScrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        placeInfoView.snp.makeConstraints { make in
            make.top.equalTo(imageScrollView.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(58)
        }
        
        visitDateInfoView.snp.makeConstraints { make in
            make.top.equalTo(placeInfoView.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(58)
        }
        
        memoInfoView.snp.makeConstraints { make in
            make.top.equalTo(visitDateInfoView.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualTo(258)
            make.bottom.equalToSuperview().inset(28)
        }
        
    }
    override func configureView() {
        contentView.backgroundColor = ColorStyle.customWhite
        scrollView.showsVerticalScrollIndicator = false
        
        imageScrollView.isPagingEnabled = true
        imageScrollView.isScrollEnabled = true
        imageScrollView.backgroundColor = .gray
        pageControl.currentPage = 0
        
        placeInfoView.titleLabel.text = "장소"
        placeInfoView.iconImageView.image = ImageStyle.mark
        placeInfoView.iconImageView.tintColor = ColorStyle.customGray
        
        visitDateInfoView.titleLabel.text = "방문 날짜"
        visitDateInfoView.iconImageView.image = ImageStyle.clock
        
        memoInfoView.titleLabel.text = "메모"
    }
}

