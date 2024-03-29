//
//  MapView.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import Foundation
import NMapsMap
import SnapKit

final class MapView: BaseView {
    let naverMapView = NMFMapView()
    let moveCurrentLoactionButton = UIButton()
    let addRecordButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(naverMapView)
        addSubview(moveCurrentLoactionButton)
        addSubview(addRecordButton)
    }
    override func configureLayout() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        moveCurrentLoactionButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(60)
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(40)
        }
        addRecordButton.snp.makeConstraints { make in
            make.top.equalTo(moveCurrentLoactionButton.snp.bottom).offset(24)
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(40)
        }
    }
    override func configureView() {
        naverMapView.allowsZooming = true
        
        var addRecordConfig = UIButton.Configuration.filled()
        addRecordConfig.image = ImageStyle.plus
        addRecordConfig.cornerStyle = .capsule
        addRecordConfig.baseBackgroundColor = ColorStyle.mapmoColor
        addRecordButton.configuration = addRecordConfig
        
        naverMapView.logoAlign = .leftTop
        
        var currentLocationConfig = UIButton.Configuration.filled()
        currentLocationConfig.image = ImageStyle.currentLocation
        currentLocationConfig.cornerStyle = .capsule
        currentLocationConfig.baseBackgroundColor = ColorStyle.customWhite
        currentLocationConfig.baseForegroundColor = ColorStyle.customBlack
        moveCurrentLoactionButton.configuration = currentLocationConfig
        moveCurrentLoactionButton.layer.shadowColor = ColorStyle.customGray.cgColor
        moveCurrentLoactionButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        moveCurrentLoactionButton.layer.shadowOpacity = 0.3
        moveCurrentLoactionButton.layer.shadowRadius = 3
    }
}

