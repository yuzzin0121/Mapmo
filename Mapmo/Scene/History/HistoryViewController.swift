//
//  HistoryViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit

final class HistoryViewController: BaseViewController {
    let mainView = HistoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.historySementedVC.didMove(toParent: self)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = TabItem.history.title
    }

}
