//
//  DetailRecordView.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit
import SnapKit

class DetailRecordView: BaseView {
    let editButton = {
        let image = ImageStyle.edit
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        button.tintColor = ColorStyle.customBlack
        button.setImage(image, for: .normal)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
        button.configuration = configuration
        return button
    }()
    let deleteButton = {
        let image = ImageStyle.trash
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        button.tintColor = ColorStyle.customBlack
        button.setImage(image, for: .normal)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
        button.configuration = configuration
        return button
    }()
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
        contentView.addSubviews([imageScrollView, pageControl,placeInfoView, visitDateInfoView, memoInfoView])
        
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
        pageControl.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(imageScrollView).inset(10)
            make.height.equalTo(10)
        }
        
        placeInfoView.snp.makeConstraints { make in
            make.top.equalTo(imageScrollView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(57)
        }
        
        visitDateInfoView.snp.makeConstraints { make in
            make.top.equalTo(placeInfoView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(57)
        }
        
        memoInfoView.snp.makeConstraints { make in
            make.top.equalTo(visitDateInfoView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualTo(257)
            make.bottom.equalToSuperview().inset(28)
        }
        
    }
    override func configureView() {
        
        contentView.backgroundColor = ColorStyle.customWhite
        scrollView.showsVerticalScrollIndicator = false
        
        imageScrollView.isPagingEnabled = true
        imageScrollView.isScrollEnabled = true
        imageScrollView.backgroundColor = ColorStyle.customWhite
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.showsHorizontalScrollIndicator = false
        
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        
        placeInfoView.titleLabel.text = "장소"
        placeInfoView.iconImageView.image = ImageStyle.mark
        placeInfoView.iconImageView.tintColor = ColorStyle.customGray
        
        visitDateInfoView.titleLabel.text = "방문 날짜"
        visitDateInfoView.iconImageView.image = ImageStyle.clock
        
        memoInfoView.titleLabel.text = "메모"
    }
}

