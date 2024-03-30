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
        mainView.historySementedVC.passDelegate = self
        mainView.historySementedVC.showCreateDelegate = self
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        navigationItem.title = TabItem.history.title
    }

}

extension HistoryViewController: PassDataAndShowVCDelegate {
    func showDetailRecordVC(recordItem: RecordItem) {
        let detailRecordVC = DetailRecordViewController()
        detailRecordVC.detailRecordViewModel.inputRecordItem.value = recordItem
        detailRecordVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailRecordVC, animated: true)
    }
}

extension HistoryViewController: ShowCreateRecordDelegate {
    func showCreateRecordVC() {
        let selectCategoryVC = SelectCategoryViewController()
        navigationController?.pushViewController(selectCategoryVC, animated: true)
    }
}



protocol PassDataAndShowVCDelegate: AnyObject {
    func showDetailRecordVC(recordItem: RecordItem)
}
