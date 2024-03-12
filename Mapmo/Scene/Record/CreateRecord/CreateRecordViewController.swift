//
//  CreateRecordViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

final class CreateRecordViewController: BaseViewController {
    let mainView = CreateRecordView()
    let createRecordViewModel = CreateRecordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "기록 생성하기"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = .customBlack
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
}
