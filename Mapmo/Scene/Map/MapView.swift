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
    
    override func configureHierarchy() {
        addSubview(naverMapView)
    }
    override func configureLayout() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureView() {
        naverMapView.allowsZooming = true
    }
}

