//
//  RecordCardView.swift
//  Mapmo
//
//  Created by 조유진 on 3/23/24.
//

import UIKit
import SnapKit

class RecordCardView: BaseView {
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
            make.trailing.greaterThanOrEqualTo(heartButton.snp.leading).offset(-8)
            make.height.equalTo(15)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(placeLabel.snp.top).offset(-8)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        heartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.size.equalTo(22)
        }
    }
    override func configureView() {
        gradientView.applyGradientBackground()
        thumbnailImageView.contentMode = .scaleAspectFill
        
        placeLabel.design(textColor: .white)
        memoLabel.design(textColor: .white)
        heartButton.setImage(ImageStyle.heart, for: .normal)
        heartButton.tintColor = .white
    }
}
