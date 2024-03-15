//
//  MapViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit

final class MapViewController: BaseViewController {
    let mainView = MapView()
    
    let mapViewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAction()
        mapViewModel.addRecordButtonTrigger.bind { value in
            guard let value = value else { return }
            self.showAddRecordVC()
        }
    }
    
    private func showAddRecordVC() {
        let selectCategoryVC = SelectCategoryViewController()
        selectCategoryVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(selectCategoryVC, animated: true)
    }
    
    @objc private func addRecordButtonClicked() {
        mapViewModel.addRecordButtonTrigger.value = ()
    }
    
    private func setAction() {
        mainView.addRecordButton.addTarget(self, action: #selector(addRecordButtonClicked), for: .touchUpInside)
    }
    
    override func loadView() {
        view = mainView
    }
    
}

