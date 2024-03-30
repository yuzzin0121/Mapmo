//
//  MemoInfoView.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import UIKit
import SnapKit

final class MemoInfoView: UIView, ViewProtocol {
    
    let titleLabel = UILabel()
    let memoTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    // MARK: - Configure
    func configureHierarchy() {
        addSubviews([titleLabel, memoTextView])
    }
    
    // InfoView의 높이 - 17 + 240
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(17)
        }
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(240)
        }
    }
    
    func configureView() {
        titleLabel.design(font: .pretendard(size: 17, weight: .semiBold))
        memoTextView.backgroundColor = ColorStyle.customBackgroundGray
        memoTextView.layer.cornerRadius = 12
        memoTextView.clipsToBounds = true
        memoTextView.font = .pretendard(size: 16, weight: .regular)
        memoTextView.textColor = ColorStyle.customBlack
        memoTextView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
