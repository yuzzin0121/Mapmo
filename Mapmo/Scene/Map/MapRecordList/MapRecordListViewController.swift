//
//  MapRecordListViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/16/24.
//

import UIKit

class MapRecordListViewController: BaseViewController {
    let mainView = MapRecordListView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        view = mainView
    }
    
}
