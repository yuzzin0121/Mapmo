//
//  MemoInfoView.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit
import SnapKit

class MemoInfoView: UIView, ViewProtocol {
    
    let titleLabel = UILabel()
    let memoBackgroundView = UIView()
    let memoTitleLabel = UILabel()
    let contentTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        addSubviews([titleLabel, memoBackgroundView])
        [memoTitleLabel, contentTextView].forEach {
            memoBackgroundView.addSubview($0)
        }
    }
    
    // InfoView의 높이 - 18 + 240
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(18)
        }
        memoBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(240)
        }
        memoTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(18)
            make.height.equalTo(18)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(memoTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureView() {
        titleLabel.design(font: .pretendard(size: 18, weight: .semiBold))
        memoBackgroundView.backgroundColor = ColorStyle.customBackgroundGray
        memoBackgroundView.layer.cornerRadius = 12
        memoBackgroundView.clipsToBounds = true
        memoTitleLabel.design(font: .pretendard(size: 18, weight: .semiBold))
        contentTextView.font = .pretendard(size: 16, weight: .regular)
        contentTextView.isEditable = false
        contentTextView.backgroundColor = .clear
        contentTextView.textColor = ColorStyle.customBlack
        contentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
