//
//  SelectCategoryViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    let mainView = SelectCategoryView()

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func loadView() {
        view = mainView
    }

}
