//
//  InputMemoCollectionViewCell.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

final class InputMemoCollectionViewCell: UICollectionViewCell {
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let memoTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        [iconImageView, titleLabel, memoTextView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(6)
            make.centerY.equalTo(iconImageView)
            make.height.equalTo(16)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureView() {
        iconImageView.image = InputRecordSection.memo.icon
        
        titleLabel.design(text: InputRecordSection.memo.title, font: .pretendard(size: 16, weight: .bold))
       
        memoTextView.backgroundColor = ColorStyle.customBackgroundGray
        memoTextView.layer.cornerRadius = 12
        memoTextView.clipsToBounds = true
        memoTextView.text = "내용 입력"
        memoTextView.font = .pretendard(size: 17, weight: .regular)
        memoTextView.textColor = ColorStyle.customGray
        memoTextView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
