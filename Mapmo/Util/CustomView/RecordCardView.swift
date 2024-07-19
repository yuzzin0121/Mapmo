//
//  RecordCardView.swift
//  Mapmo
//
//  Created by 조유진 on 3/23/24.
//

import UIKit
import SnapKit

final class RecordCardView: BaseView {
    let thumbnailImageView = UIImageView()
    let gradientView = UIView()
    let placeLabel = UILabel()
    let memoLabel = UILabel()
    let heartButton = UIButton()
    
    override func configureHierarchy() {
        addSubviews([thumbnailImageView, gradientView])
        gradientView.addSubviews([placeLabel, memoLabel, heartButton])
    }
    override func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        placeLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(12)
            make.trailing.lessThanOrEqualTo(heartButton.snp.leading).offset(-8)
            make.height.equalTo(15)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(placeLabel.snp.top).offset(-4)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        heartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.size.equalTo(22)
        }
    }
    override func configureView() {
        DispatchQueue.main.async {
            self.gradientView.applyGradientBackground()
        }
        thumbnailImageView.contentMode = .scaleAspectFill
        
        placeLabel.design(textColor: .white, font: .pretendard(size: 15, weight: .regular))
        memoLabel.design(textColor: .white, font: .pretendard(size: 16, weight: .semiBold))
        heartButton.setImage(ImageStyle.heart, for: .normal)
        heartButton.tintColor = .white
    }
}
