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
    let addRecordButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(naverMapView)
        naverMapView.addSubview(addRecordButton)
    }
    override func configureLayout() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addRecordButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(100)
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(40)
        }
    }
    override func configureView() {
        naverMapView.allowsZooming = true
        addRecordButton.backgroundColor = ColorStyle.mapmoColor
        var config = addRecordButton.configuration
        config?.image = ImageStyle.plus
        addRecordButton.configuration = config
        
    }
}

