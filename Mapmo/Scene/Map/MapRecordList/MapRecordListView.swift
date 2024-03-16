//
//  MapRecordListView.swift
//  Mapmo
//
//  Created by 조유진 on 3/16/24.
//

import UIKit
import SnapKit

class MapRecordListView: BaseView {
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        tableView.backgroundColor = .systemGray6
    }
}


