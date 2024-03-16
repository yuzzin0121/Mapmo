//
//  FloatingPanelController+Extension.swift
//  Mapmo
//
//  Created by 조유진 on 3/16/24.
//

import UIKit
import FloatingPanel

extension FloatingPanelController {
    func designPanel() {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        
        
        appearance.cornerRadius = 30
        appearance.backgroundColor = ColorStyle.customWhite
        surfaceView.appearance = appearance
    }
}
