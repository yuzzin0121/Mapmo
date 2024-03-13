//
//  SearchPlaceViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/13/24.
//

import UIKit

class SearchPlaceViewController: BaseViewController {
    let mainView = SearchPlaceView()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "장소 검색"
        
        let backButton = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
        backButton.tintColor = ColorStyle.customBlack
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func popView() {
        navigationController?.popViewController(animated: true)
    }
}
