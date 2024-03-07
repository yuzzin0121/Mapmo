//
//  MapViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit

final class MapViewController: BaseViewController {
    let mainView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func loadView() {
        view = mainView
    }
    
}

