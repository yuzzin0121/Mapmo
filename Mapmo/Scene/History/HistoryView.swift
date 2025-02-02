//
//  HistoryView.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit
import SnapKit

final class HistoryView: BaseView {
    let containerView =  {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 5
        return view
    }()
    
    let historySementedVC = HistorySegmentedViewController()
    
    override func configureHierarchy() {
        addSubviews([containerView])
        containerView.addSubview(historySementedVC.view)
    }
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        historySementedVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureView() {
    }
}
