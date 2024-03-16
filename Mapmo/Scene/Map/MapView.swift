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
    let refreshButton = UIButton()
    let addRecordButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(naverMapView)
        addSubview(refreshButton)
        addSubview(addRecordButton)
    }
    override func configureLayout() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        addRecordButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(100)
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(40)
        }
    }
    override func configureView() {
        naverMapView.allowsZooming = true
        
        var refreshConfig = UIButton.Configuration.filled()
        refreshConfig.image = ImageStyle.refresh
        refreshConfig.title = "현 지도에서 찾기"
        refreshConfig.cornerStyle = .capsule
        refreshConfig.imagePadding = 6
        refreshConfig.baseBackgroundColor = ColorStyle.customWhite
        refreshConfig.baseForegroundColor = ColorStyle.mapmoColor
        refreshButton.configuration = refreshConfig
        
        var addRecordConfig = UIButton.Configuration.filled()
        addRecordConfig.image = ImageStyle.plus
        addRecordConfig.cornerStyle = .capsule
        addRecordConfig.baseBackgroundColor = ColorStyle.mapmoColor
        addRecordButton.configuration = addRecordConfig
        
        
    }
}

